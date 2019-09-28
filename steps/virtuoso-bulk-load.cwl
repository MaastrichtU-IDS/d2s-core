#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Bulk load RDF to Virtuoso
requirements:
  InlineJavascriptRequirement: {}

baseCommand: [docker, exec]

# arguments: [ "d2s-cwl-workflows_virtuoso_1", "isql-v", "-U" , "dba", "-P", "password",
# "$(exec=\"ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output','*.nq','http://test/');rdf_loader_run();\")" ]

arguments:
  - valueFrom: "d2s-cwl-workflows_virtuoso_1"
  - valueFrom: "isql-v"
  - prefix: -U
    valueFrom: "dba"
  - prefix: -P
    valueFrom: "password"
  - prefix: -C
    valueFrom: |
      ${
        var r = "exec=\"ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output','*.nq','http://test/');rdf_loader_run();\")";
        return r;
      }

# docker exec -it docker-compose_virtuoso_1 isql-v -U dba -P password exec="ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output', '*.nq', 'http://test/'); rdf_loader_run();"

# https://www.commonwl.org/user_guide/13-expressions/index.html
inputs:
  
  file_to_load:
    type: File
 
  # virtuoso_loader:
  #   type: string?
  #   default: "ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output', '*.nq', 'http://test/'); rdf_loader_run();"
  #   inputBinding:
  #     position: 1
  #     prefix: "exec="

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
    format: edam:format_1964    # Plain text

$namespaces:
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "https://identifiers.org/edam:"
  s: "https://schema.org/"
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
  - https://schema.org/docs/schema_org_rdfa.html

dct:creator:
  class: foaf:Person
  "@id": "https://orcid.org/0000-0002-1501-1082"
  foaf:name: "Vincent Emonet"
  foaf:mbox: "mailto:vincent.emonet@gmail.com"

dct:contributor:
  class: foaf:Person
  "@id": "https://orcid.org/0000-0000-ammar-ammar"
  foaf:name: "Ammar Ammar"
  foaf:mbox: "mailto:a.ammar@student.maastrichtuniversity.nl"

# dct:license: "https://opensource.org/licenses/MIT"