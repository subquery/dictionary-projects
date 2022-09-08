if [ $# -eq 0 ]
  then
    echo "Pass token argument to use publishing script"
    exit 1
fi

echo "Running IPFS Publishing Script \n"

cd ../dictionaries

for d in */ ; do
    project=$(echo $d | sed 's:/*$::')
    echo "Building and Publishing $project dictionary"

    (cd $d 
        yarn build
        output=$(SUBQL_ACCESS_TOKEN=$1 subql publish)
        ipfs=$(echo $output | awk '{print $NF}')
        echo "$project IPFS hash: $ipfs \n"
    )
    
done