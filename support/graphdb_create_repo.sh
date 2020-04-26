#!/bin/bash

# TODO: add a parameters to define the triplestore URL in d2s-bash-exec args
# echo if command failed (we don't want to stop the workflow for this)
curl -X POST http://graphdb:7200/rest/repositories -H 'Content-Type: multipart/form-data' -F "config=@d2s-core/support/graphdb-repo-config.ttl" || echo "cURL to create GraphDB test repository failed."