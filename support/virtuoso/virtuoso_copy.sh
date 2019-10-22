#!/bin/bash

# Copy the RDF output file from xml2rdf or r2rml to the shared dir
# cp rdf_output.nq /data/d2s-workspace/virtuoso/
echo "pwd virtuoso_copy"
pwd
echo "Virtuoso copy directory content:"
ls
# cp *.(nq|ttl|rdf|nt) "/data/d2s-workspace/" # doesn't work in a script...
# virtuoso_copy.sh: line 7: syntax error near unexpected token `('
# virtuoso_copy.sh: line 7: `cp *.(nq|ttl|rdf|nt) "/data/d2s-workspace/virtuoso/"'

cp *.nq "/data/d2s-workspace/virtuoso"
cp /tmp/*.ttl "/data/d2s-workspace/virtuoso"
cp /tmp/*.rdf /data/d2s-workspace/virtuoso
cp /tmp/*.nt /data/d2s-workspace/virtuoso


# Copy virtuoso load.sh script to shared dir
cp $1 /data/d2s-workspace/virtuoso

chmod +x /data/d2s-workspace/virtuoso/load.sh

# cp $1 /data/d2s-workspace/virtuoso/