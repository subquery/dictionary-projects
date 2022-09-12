#!/bin/sh
if [ $# -eq 0 ]
  then
    echo "Pass token argument to use publishing script"
    exit 1
fi

printf 'Running IPFS Publishing Script \n'

cd ../dictionaries || exit

for d in */ ; do
    project=$(echo "$d" | sed 's:/*$::')
    echo "Building and publishing $project dictionary"

    (cd "$d" || exit  
        yarn build
        SUBQL_ACCESS_TOKEN=$1 subql publish
    )
    
done