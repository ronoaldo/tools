#!/usr/bin/env python2
# -*- coding:utf-8 -*-

from xmlrpclib import Server,Fault
from optparse import OptionParser

import json
import sys
import csv
import datetime

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
        parser.add_option("-l", "--limit", dest="limit", default=sys.maxint)
        parser.add_option("-a", "--account", dest="account")
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

    def campaign_summary(self):
        """
        Export all statistics for all mailings in the current account.
        """
        api = BenchmarkEmailApi(token=self.options.token)

        page = 0
        page_size = 300
        done = False
        count = 0

        csv_writer = csv.writer(sys.stdout)
        csv_writer.writerow(["account","id", "emailName", "toListName", \
                "status", "createdDate", "scheduleDate", \
                "mailSent", "opens", "clicks", "bounces",
                "unsubscribers", "abuseReports", "subject"])
        while not done:
            campaigns = api.reportGet("", page, page_size, "date", "asc")

            for c in campaigns:
                s = api.reportGetSummary(c["id"])
                csv_writer.writerow([self.options.account,
                    c["id"], c["emailName"], c["toListName"], \
                    c["status"], c["createdDate"], c["scheduleDate"], \
                    s["mailSent"], s["opens"], s["clicks"], s["bounces"], \
                    s["unsubscribes"], s["abuseReports"], ])
                count += 1
            if len(campaigns) < page_size or count >= self.options.limit:
                done = True
            page += 1
            sys.stdout.flush()

    def list_bounces(self):
        """
        Export all bounces from the current account, for all lists
        """
        self._export_by_type("ConfirmedBounces")

    def list_optout(self):
        """
        Export all optouts from the current account, for all lists
        """
        self._export_by_type("Optout")

    # Internal helper methods

    def _export_by_type(self, contact_type):
        """
        Export all contacts from all lists, by given type.

        Types can be one of:
            Optin, NotOptedIn, ConfirmedBounces, Active, Unsubscribe
        """
        api = BenchmarkEmailApi(token=self.options.token)
        lists = api.listGet("", 0, 300, "", "")
        print >> sys.stderr, "Exporting %s lists ..." % len(lists)
        csv_writer = csv.writer(sys.stdout)
        csv_writer.writerow(["account", "listname", "email", "domain",
            "eventtype", "eventdate",])

        for i, l in enumerate(lists):
            page = 0
            page_size = 100
            if page_size > self.options.limit:
                page_size = self.options.limit
            done = False
            count = 0

            while not done:
                contacts = api.listGetContactsByType(
                        l["id"], "", page, page_size, "" ,"", contact_type
                        )
                for j, c in enumerate(contacts):
                    d = api.listGetContactDetails(l["id"], c["email"])
                    domain = c["email"].split("@")[1]
                    mtime = datetime.datetime.strptime(d['timestamp'], "%b %d, %Y")
                    csv_writer.writerow([self.options.account,
                        l["listname"], c["email"], domain,
                        contact_type, mtime.isoformat(),])
                    sys.stdout.flush()
                    count += 1

                if len(contacts) < page_size or count >= self.options.limit:
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
