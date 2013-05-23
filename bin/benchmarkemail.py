#!/usr/bin/env python
# -*- coding:utf-8 -*-

from xmlrpclib import Server,Fault
from optparse import OptionParser

import json
import sys

class BenchmarkEmailApiError(Exception):
    """
    Error raised when the API call fails
    """
    pass

class BenchmarkEmailApi(object):
    """
    Client for BenchmarkEmail API 1.0
    """

    def __init__(self, username=None, password=None, token=None,
            endpoint='http://api.benchmarkemail.com/1.0'):
        self.token = token
        self.server = Server(endpoint)

    def __getattr__(self, method_name):
        def get(self, *args, **kwargs):
            try:
                result = getattr(self.server, method_name, None)(self.token, *args)
                return result
            except Fault, err:
                raise BenchmarkEmailApiError(err)
        return get.__get__(self)

    def call(self, method_name, *args):
        return getattr(self, method_name)(*args)

class BenchmarkEmailCli(object):
    """
    Command line interface for scripting with the BenchmarkEmail API
    """

    def __init__(self):
        self.options, self.args = self.parse_options()

    def parse_options(self):
        parser = OptionParser()
        parser.add_option("-t", "--token", dest="token")
        parser.add_option("-m", "--method", dest="method")
        parser.add_option("-s", "--script", dest="script")
        return parser.parse_args()

    def run(self):
        if not self.options.token:
            raise RuntimeError("Token parameter is mandatory")

        if self.options.script:
            script = self.options.script
            if script.startswith("_") or script in ["run_from_cli", "type_safe_args", "run"]:
                raise RuntimeError("Invalid script name: " + script)
            if hasattr(self, self.options.script):
                getattr(self, self.options.script)()
        elif self.options.method:
            self.run_from_cli()
        else:
            raise RuntimeError("Please inform a method name or script")

    # Scripts

    def export_bounces(self):
        """
        Export all bounces from the current account, for all lists
        """
        self._export_by_type("ConfirmedBounces")

    def export_optout(self):
        """
        Export all optouts from the current account, for all lists
        """
        self._export_by_type("Optout")

    def _export_by_type(self, contact_type):
        """
        Export all contacts from all lists, by given type.

        Types can be one of:
            Optin, NotOptedIn, ConfirmedBounces, Active, Unsubscribe
        """
        api = BenchmarkEmailApi(token=self.options.token)
        lists = api.listGet("", 0, 300, "", "")
        print >> sys.stderr, "Exporting %s lists ..." % len(lists)

        for i, l in enumerate(lists):
            page = 0
            page_size = 100
            done = False

            while not done:
                contacts = api.listGetContactsByType(
                    l["id"], "", page, page_size, "" ,"", contact_type
                )
                for j, c in enumerate(contacts):
                    print "%s,%s" % (l["listname"], c["email"])

                if len(contacts) < page_size:
                    done = True
                page += page_size

    # Builtin

    def run_from_cli(self):
        api = BenchmarkEmailApi(token=self.options.token)
        result = api.call(self.options.method, *self.type_safe_args())
        if result:
            self.print_result(result)
        else:
            print >>sys.stderr, "No results"

    def type_safe_args(self):
        args = list()
        for a in self.args:
            if a.startswith("i:"):
                args.append(int(a.split(":")[1]))
            else:
                args.append(a)
        return args

    def print_result(self, result):
        print json.dumps(result, indent=2)

# Entry point for the cli interface
if __name__ == "__main__":
    bme = BenchmarkEmailCli()
    bme.run()
