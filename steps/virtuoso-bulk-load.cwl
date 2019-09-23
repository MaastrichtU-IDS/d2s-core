#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

label: Data2Services tool to bulk load RDF to a Virtuoso triplestore, Vincent Emonet <vincent.emonet@gmail.com> 


baseCommand: [docker, exec]

arguments: [ "data2services-cwl-workflows_virtuoso_1", "isql-v", "-U" , "dba", "-P", "password",
"exec=\"ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output','*.nq','http://test/');rdf_loader_run();\""]

# docker exec -it docker-compose_virtuoso_1 isql-v -U dba -P password exec="ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output', '*.nq', 'http://test/'); rdf_loader_run();"

inputs:
  
  working_directory:
    type: string
  dataset:
    type: string
  nquads_file:
    type: File
  virtuoso_loader:
    type: string?
    default: "ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output', '*.nq', 'http://test/'); rdf_loader_run();"
    inputBinding:
      position: 1
      prefix: "exec="
  # sparql_triplestore_url:
  #   type: string?
  #   inputBinding:
  #     position: 1
  #     prefix: -url
  # sparql_triplestore_repository:
  #   type: string?
  #   inputBinding:
  #     position: 2
  #     prefix: -rep

stdout: rdf-upload.txt

outputs:
  rdf_upload_logs:
    type: stdout
