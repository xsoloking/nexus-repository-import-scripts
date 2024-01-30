#!/bin/bash

# copy and run this script to the root of the repository directory containing files
# this script attempts to exclude uploading itself explicitly so the script name is important
# Get command line params
while getopts ":r:u:p:" opt; do
	case $opt in
		r) REPO_URL="$OPTARG"
		;;
		u) USERNAME="$OPTARG"
		;;
		p) PASSWORD="$OPTARG"
		;;
	esac
done

AUTH=$(echo -n "${USERNAME}:${PASSWORD}" | base64 -w 0)

mkdir -p ~/.gem/
cat > ~/.gem/nexus << EOF
---
:url: $REPO_URL
:authorization: Basic $AUTH
EOF

find . -type f -not -path '*/\.*' -name '*.gem' -exec gem nexus {} \;
