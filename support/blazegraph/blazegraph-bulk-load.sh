# Arg $1 is the input RDF file to load
# Arg $2 is the URL to dataloader.txt to ddl

# Remove previous files
rm -rf /data/blazegraph-load/*

# Copy input RDF file to the blazegraph directory
cp -r $1 /data/blazegraph-load/

# Download dataloader file
#wget $2

echo "namespace=kb
propertyFile=/RWStore.properties
fileOrDirs=/data/blazegraph-load
defaultGraph=https://w3id.org/d2s/graph/default
quiet=false
verbose=0
closure=false
durableQueues=true" > dataloader.txt

# Format should be inferred
#format=n-triples

# Send query to bulk load file to Blazegraph
curl -X POST --data-binary @dataloader.txt --header 'Content-Type:text/plain' \
http://blazegraph:8080/bigdata/dataloader