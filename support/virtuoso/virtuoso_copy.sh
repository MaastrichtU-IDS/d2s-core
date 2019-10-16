#!/bin/bash

# Copy the RDF output file from xml2rdf or r2rml to the shared dir
# cp rdf_output.nq /data/d2s-workspace/
echo "GET DIRECTORYY"
ls
# cp *.(nq|ttl|rdf|nt) "/data/d2s-workspace/" # doesn't work in a script...
# virtuoso_copy.sh: line 7: syntax error near unexpected token `('
# virtuoso_copy.sh: line 7: `cp *.(nq|ttl|rdf|nt) "/data/d2s-workspace/"'

cp *.nq "/data/d2s-workspace/"
cp *.ttl "/data/d2s-workspace/"
cp *.rdf "/data/d2s-workspace/"
cp *.nt "/data/d2s-workspace/"


# Copy virtuoso load.sh script to shared dir
cp $1 /data/d2s-workspace

chmod +x /data/d2s-workspace/load.sh

# cp $1 /data/d2s-workspace/