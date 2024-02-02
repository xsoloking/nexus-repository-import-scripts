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


cat > ~/.pypirc << EOF
[distutils]
index-servers =
  pypi
[pypi]
repository: $REPO_URL
username: ${USERNAME}
password: ${PASSWORD}
EOF

find . -type f -not -path '*/\.*' -name '*.tar.gz' -o -name '*.whl' -o -name '*.tgz' -exec twine upload -r pypi {} \;
