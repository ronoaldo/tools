#!/bin/bash

# Copyright 2011 Ronoaldo JLP
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Constants
eclipse="$HOME/bin/eclipse-indigo-sr1-64bits"
program="$( basename $0 )"

# Default features
FEATURES="com.google.gdt.eclipse.suite.e37.feature.feature.group,\
com.google.appengine.eclipse.sdkbundle.e37.feature.feature.group,\
com.google.gwt.eclipse.sdkbundle.e37.feature.feature.group,\
mercurialeclipse.feature.group,\
org.apache.ivy.feature.feature.group,\
org.apache.ivyde.feature.feature.group"

# Default update-sites
UPDATE_SITES="http://download.eclipse.org/releases/indigo/,\
http://dl.google.com/eclipse/plugin/3.7,\
http://cbes.javaforge.com/update/,\
http://www.apache.org/dist/ant/ivyde/updatesite/"

# Print help and exit
usage() {
  cat <<EOF
$program - Eclipse Feature Install Script
Copyright 2011-2012 (C) Ronoaldo JPL <ronoaldo@gmail.com>

Usage $program [OPTIONS]

Where [OPTINOS] can be:

  -e|--eclipse		Path to the eclipse binary
  -r|--repository	Add a repository to be used when installing
  -f|--features		Add a feature to the install queue
  -D|--defaults		Includes the default features and repositories
  -i|--install		Install the features in the queue
  -d|--discover		Discover the repositories for feature groups available for
			instalation

Default update sites:
$(echo $UPDATE_SITES | tr ',' '\n')

Default features to install:
$(echo $FEATURES | tr ',' '\n')	
EOF
  exit 1
}


# Exits with a fatal error message
fatal() {
  echo "$program:ERROR: $*" >&2
  exit 1
}

# Display a warning message
warn() {
  echo "$program:WARN: $*" >&2
}

check_env() {
  if [ -z $eclipse ]; then fatal "-e|--eclipse is required." ; fi
}

# Discover avaiable features
discover() {
  check_env
  $eclipse -nosplash -application org.eclipse.equinox.p2.director \
    -repository ${1#,} -list | grep --color=auto feature.group
}

# Install all informed features
install_features() {
  check_env
  for feature in $(echo ${2#,} | tr ',' ' '); do
    echo "Adding $feature ..."
    $eclipse -nosplash -application org.eclipse.equinox.p2.director \
      -repository ${1#,} \
      -installIU $feature \
      -tag "Added-$feature"
    echo -e "$feature successfully added"
    echo
  done
}

# Main
TEMP=`getopt -n $program \
  -o dDihe:r:f: \
  --long discover,defaults,install,help,eclipse:,repository:,feature: -- "$@"`
if [ $? != 0 ] ; then fatal "Terminating..." ; fi

export features=
export update_sites=
export eclipse=

eval set -- "$TEMP"
# Parse the options and actions to be performed
while [ $# -gt 0 ] ; do
  case $1 in
    -D|--defaults)
      export features="$features,$FEATURES"
      export update_sites="$update_sites,$UPDATE_SITES"
      shift;
    ;;
    
    -f|--feature)
      export features="$features,$2"
      shift 2;
    ;;

    -r|--repository)
      export update_sites="$update_sites,$2"
      shift 2;
    ;;

    -e|--eclipse)
      export eclipse="$( eval readlink -f $2 )"
      shift 2;
    ;;

    *)
      shift
    ;;
  esac
done

# Run the actions
eval set -- "$TEMP"
while [ $# -gt 0 ]; do
  case $1 in
    -i|--install)
      install_features "$update_sites" "$features"
      shift
    ;;

    -d|--discover)
      discover "$update_sites"
      shift
    ;;

    -h|--help)
      usage
      shift
    ;;

    --)
      shift;
    ;;

    *)
      shift;
    ;;
  esac
done