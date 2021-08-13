#!/bin/bash

usage() {
    cat <<EOF
gen.sh - validates tooling documentaation and generates README.md

Options:
    -h
        Displays this help message an exit.
EOF
}

# Main
case $1 in
    -h|--help) usage; exit 1;
esac

for tool in ../bin/* ; do
    name=$(basename $tool)
	echo "## $name"
    echo
    echo "Uses $(head -n 1 $tool) as interpreter"
    echo
    echo '```'
	$tool --help
    echo '```'
    echo
done
