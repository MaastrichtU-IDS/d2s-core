#!/bin/bash

# Copy the RDF output file from xml2rdf or r2rml to the shared dir
# cp rdf_output.nq /data/d2s-kg/
echo "GET DIRECTORYY"
ls
# cp *.(nq|ttl|rdf|nt) "/data/d2s-kg/" # doesn't work in a script...
# virtuoso_copy.sh: line 7: syntax error near unexpected token `('
# virtuoso_copy.sh: line 7: `cp *.(nq|ttl|rdf|nt) "/data/d2s-kg/"'

cp *.nq "/data/d2s-kg/"
cp *.ttl "/data/d2s-kg/"
cp *.rdf "/data/d2s-kg/"
cp *.nt "/data/d2s-kg/"


# Copy virtuoso load.sh script to shared dir
cp $1 /data/d2s-kg

chmod +x /data/d2s-kg/load.sh

# cp $1 /data/d2s-kg/