## ``base64url``

Uses `#!/usr/bin/env python` as interpreter

```
usage: base64url [-h] [--decode]

URLsafe base 64 encoder/decoder

optional arguments:
  -h, --help    show this help message and exit
  --decode, -d  decode instead of encode.
```

## ``benchmarkemail.py``

Uses `#!/usr/bin/env python2` as interpreter

```
Usage: benchmarkemail.py [options]

Options:
  -h, --help            show this help message and exit
  -t TOKEN, --token=TOKEN
  -m METHOD, --method=METHOD
  -s SCRIPT, --script=SCRIPT
  -l LIMIT, --limit=LIMIT
  -a ACCOUNT, --account=ACCOUNT
```

## ``binarr``

Uses `#!/bin/bash` as interpreter

```
binarr - binary file to byte array

Simple utility to dump binary files as byte arrays

Usage:
	binarr [OPTIONS] binary_file

Where OPTIONS can be:
	-h|--help	displays this message and exits.
```

## ``bqbkp``

Uses `#!/bin/bash` as interpreter

```
Usage bqbkp DATASET [gs://BUCKET/[PREFIX] | PREFIX]

DATASET will be backed up either in a local folder if PREFIX
doesn't start with gs://, otherwise, it will be backed up to
the provided bucket and prefix path.
```

## ``check-ssl``

Uses `#!/bin/bash` as interpreter

```
Usage:  check-ssl HOST

Will check and validate the provided HOST SSL certificates.
Use the environment variable SSL_PORT to change the connection port
from 443 to something else.
```

## ``cloud-vision``

Uses `#!/bin/bash` as interpreter

```
../bin/cloud-vision ocr image-path
```

## ``colorscheme``

Uses `#!/bin/bash` as interpreter

```
Usage: colorscheme

Prints the foreground/background colors in your terminal.
```

## ``csv2html``

Uses `#!/bin/bash` as interpreter

```
csv2html: converts CSV files into HTML tables.

Tested on simple files, without quoting. May produce
funky results in those cases.

Usage:
    -h|--help   displays this help and exit.
```

## ``dns-dump``

Uses `#!/bin/bash` as interpreter

```
Use ../bin/dns-dump NAKED_DOMAIN

This will print out a set of common DNS records for the given
naked domain and the following sub-domains: www. mx.
```

## ``dpkg-purge-all``

Uses `#!/bin/bash` as interpreter

```
dpkg-purge-all - shortcut to remove unused configuration
files from Debian systems.

*** USE AT YOUR OWN RISK ***

Usage: dpkg-purge-all [-l|--list|--remove]

	-l
	--list
		list removed packages with configurations
		left on your system

	--remove
		remove all configuration files from
		removed packages.
```

## ``gmail``

Uses `#!/usr/bin/env python2` as interpreter

```
Usage: gmail [options]

Options:
  -h, --help  show this help message and exit
  -s SUBJECT  
  -f SENDER   
```

## ``grep-my-tar``

Uses `#!/bin/bash` as interpreter

```
Usage: grep-my-tar TARFILE KEYWORD

This script will help you find a keyword inside all
files in a .tar/.tar.gz archive. It will use the Awk
command to search for keyword and print the filename
when the keyword matches.
```

## ``jardiff``

Uses `#!/bin/bash` as interpreter

```
jardiff 1.0 - Copyright (C) 2013 Ronoaldo JLP
Displays diferences in two jar/zip files.

Use jardiff jar1 jar2

Examples:
	jardiff commons-collections-3.2.jar commons-collections-3.2.1.jar

```

## ``kernelbuild``

Uses `#!/bin/bash` as interpreter

```
Usage ../bin/kernelbuild [OPTIONS]

Where OPTIONS can be:
	--kernel-version|-k
		Configures the kernel version (default=latest)
	--fast
		Enable multiple jobs in parallel. 24 jobs
	--build-number|-b
		Enables a specific build number after 
		"~custom" on kernel package revision
	--safe-config
		Try to safely configure the kernel
	--optimal-config
		Try to make an optimized kernel configuration.
		You must have all modules loaded to help the configuration
		guess the right modules to include.
	--help
		Prints this help and ext
```

## ``launch-gc-vm.sh``

Uses `#!/bin/bash` as interpreter

```
Usage: launch-gc-vm.sh PROJECT_ID ZONE VM_NAME
```

## ``maven-alternate-settings``

Uses `#!/bin/bash` as interpreter

```
Use maven-alternate-settings --set suffix-or-name | --list
```

## ``maven-search``

Uses `#!/usr/bin/env python2` as interpreter

```
Usage: maven-search TERM [TERM..]
```

## ``p2-install``

Uses `#!/bin/bash` as interpreter

```
p2-install - Eclipse Feature Install Script
Copyright 2011-2012 (C) Ronoaldo JPL <ronoaldo@gmail.com>

Usage p2-install [OPTIONS]

Where [OPTINOS] can be:

  -e|--eclipse		Path to the eclipse binary
  -r|--repository	Add a repository to be used when installing
  -f|--features		Add a feature to the install queue
  -D|--defaults		Includes the default features and repositories
  -i|--install		Install the features in the queue
  -d|--discover		Discover the repositories for feature groups available for
			instalation

Default update sites:
http://download.eclipse.org/releases/juno/
http://dl.google.com/eclipse/plugin/4.2
http://mercurialeclipse.eclipselabs.org.codespot.com/hg.wiki/update_site/stable
http://www.apache.org/dist/ant/ivyde/updatesite/
http://download.jboss.org/jbosstools/updates/m2eclipse-wtp/
http://download.eclipse.org/technology/m2e/releases/

Default features to install:
com.google.gdt.eclipse.suite.e42.feature.feature.group
com.google.appengine.eclipse.sdkbundle.feature.feature.group
com.google.gwt.eclipse.sdkbundle.e42.feature.feature.group
mercurialeclipse.feature.group
org.apache.ivy.feature.feature.group
org.apache.ivyde.feature.feature.group
org.maven.ide.eclipse.wtp.feature.feature.group
org.eclipse.m2e.feature.feature.group
org.eclipse.m2e.logback.feature.feature.group
org.sonatype.m2e.mavenarchiver.feature.feature.group	
```

## ``path-manager``

Uses `#!/bin/bash` as interpreter

```
path-manager - Simple Path Manager for Unix

Usage: path-manager [-d|-a|-c]

Options:
	-d
	--display
	--print
		Displays currently user-friendly path, one
		entry per line
	-a path
	--add path
		Adds a new path to the path file ~/.path
	-c
	--configure
		Configures your ~/.bashrc file to read and
		add paths from ~/.path

To reload your PATH:
$ source $(which path-manager)
```

## ``random-key``

Uses `#!/bin/bash` as interpreter

```
Usage: random-key [KEY-SIZE]
```

## ``record-window``

Uses `#!/bin/bash` as interpreter

```
Records a window by selecting it with xwininfo.

Usage record-window [--gif] file.mp4
```

## ``replicate``

Uses `#!/bin/bash` as interpreter

```
Usage: replicate [--no-fail-fast|--help|-h] COMMAND

Where:
	--no-fail-fast
		Avoids calling "set -e". May be dangerous
		depending of the command you are using
	--help -h
		Prints this help and exists
```

## ``s3-repository``

Uses `#!/bin/bash` as interpreter

```
Unknown option: '--help'
s3-repository - Debian Repository on S3 (version 1.0)

Usage 0 [OPTIONS]

OPTIONS can be one of:

    --configure
        Configures the S3 repository with the configured
        parameters
   
    --export)
        Export the package indexes
       
    -i|--include ".changes file"
        Includes the package specified in the .changes file

    --incoming
        Process the incoming directory

    -r|--remove package
        Removes package from repository

    -s|--sync
        Synchronize the S3 bucket with the local repository
            (local=/var/tmp/s3-repository/debian => bucket=)

    -p|--purge-remote
        Like --sync, but removes files on remote server
        that aren't present locally. Use with caution!

```

## ``screencast``

Uses `#!/bin/bash` as interpreter

```
Simple video screencast recording tool

Usage:

screencast [--no-camera|-n]

	--no-camera|-n
		Do not open video from /dev/video0 device.

	--no-audio|-m
		Do not record audio file.

	--audio-source
		Use the specified audio as source.
		Should be a pulse source name from
		'pactl list sources'.
[I] Cleaning up ...
[I] See log output for details at /tmp/screencast-20211202-182458.mkv.log
```

## ``split-monitor``

Uses `#!/bin/bash` as interpreter

```
Usage: split-monitor LAYOUT

Where LAYOUT can be one of:
	1x1: resets to a single split
	2x1: split the screen in half
	3x1: split the screen in three parts
```

## ``virtual-monitors``

Uses `#!/bin/bash` as interpreter

```
Usage virtual-monitors SCREEN_COUNT COMMAND
```

## ``wpa-connect``

Uses `#!/bin/bash` as interpreter

```
wpa-connect - cli wpa connection tool

Usage
wpa-connect --ssid SSID --wpa-psk PASS --up
wpa-connect --down

	--ssid
		wifi SSID
	--wpa-psk
		WPA PSK passphrase
	--up
		brings interface up
	--down
		brings interface down

```

## ``youtube-stream``

Uses `#!/bin/bash` as interpreter

```
Usage: youtube-stream STREAM_KEY
```

## ``zipit``

Uses `#!/usr/bin/env python2` as interpreter

```
Usage zipit filename.zip directory
```

