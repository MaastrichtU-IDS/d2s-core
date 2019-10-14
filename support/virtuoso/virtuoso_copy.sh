#!/bin/bash

# Copy the RDF output file from xml2rdf or r2rml to the shared dir
cp rdf_output.nq /data/red-kg/

# Copy virtuoso load.sh script to shared dir
cp $1 /data/red-kg

chmod +x /data/red-kg/load.sh

# cp $1 /data/red-kg/