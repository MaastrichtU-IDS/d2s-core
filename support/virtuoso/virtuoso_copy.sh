#!/bin/bash

# Copy the RDF output file from xml2rdf or r2rml to the shared dir
# cp rdf_output.nq /data/d2s-kg/
cp "*.(nq|ttl|rdf|nt)" /data/d2s-kg/

# Copy virtuoso load.sh script to shared dir
cp $1 /data/d2s-kg

chmod +x /data/d2s-kg/load.sh

# cp $1 /data/d2s-kg/