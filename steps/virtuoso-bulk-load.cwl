#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Bulk load RDF to Virtuoso

baseCommand: [docker, exec]

# arguments: [ "-i", "virtuoso","bash", "-c", "cd /data && ./load.sh $(inputs.nquads_file.dirname) rdf_output.nq http://bio2rdf.org vload.log $(inputs.triple_store_password)"]

# arguments: [ "-i", "d2s-cwl-workflows_virtuoso_1","bash", "-c", "/tmp/load.sh $(inputs.file_to_load.dirname) rdf_output.nq http://w3id.org/data2services vload.log $(inputs.sparql_password)"]

arguments: [ "-i", "d2s-cwl-workflows_virtuoso_1", "bash", "-c", "/usr/local/virtuoso-opensource/var/lib/virtuoso/db/load.sh /usr/local/virtuoso-opensource/var/lib/virtuoso/db $(inputs.file_to_load.basename) https://w3id.org/data2services/metadata $(inputs.file_to_load.basename)_vload.log $(inputs.sparql_password)" ]


inputs:
  sparql_username:
    type: string
  sparql_password:
    type: string
  file_to_load:
    type: File
  previous_step_output:
    type: File?


stdout: logs-virtuoso-bulkload.txt

outputs:
  logs_rdf_upload:
    type: stdout
    format: edam:format_1964    # Plain text



##########################

# requirements:
#   InlineJavascriptRequirement: {}

# arguments: [ "d2s-cwl-workflows_virtuoso_1", "isql-v", "-U" , "dba", "-P", "password",
# "$(exec=\"ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output','*.nq','http://test/');rdf_loader_run();\")" ]



# arguments:
#   - valueFrom: "d2s-cwl-workflows_virtuoso_1"
#   - valueFrom: "isql-v"
#   - prefix: -U
#     valueFrom: "dba"
#   - prefix: -P
#     valueFrom: "password"
#   - prefix: -C
#     valueFrom: |
#       ${
#         var r = "exec=\"ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output','*.nq','http://test/');rdf_loader_run();\")";
#         return r;
#       }

# docker exec -it docker-compose_virtuoso_1 isql-v -U dba -P password exec="ld_dir('/usr/local/virtuoso-opensource/var/lib/virtuoso/db/output', '*.nq', 'http://test/'); rdf_loader_run();"

# https://www.commonwl.org/user_guide/13-expressions/index.html
 
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


$namespaces:
  s: "http://schema.org/"
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "http://edamontology.org/"
$schemas:
  - http://schema.org/version/latest/schema.rdf
  - https://lov.linkeddata.es/dataset/lov/vocabs/dcterms/versions/2012-06-14.n3
  - http://xmlns.com/foaf/spec/index.rdf
  - http://edamontology.org/EDAM_1.18.owl

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

edam:has_function:
  - edam:operation_3436   # Aggregation

edam:has_input: 
  - edam:format_3256    # N-Triples, no nquads

edam:has_output:
  - edam:format_2376    # RDF format
  - edam:data_0954      # Database cross-mapping

edam:has_topic:
  - edam:topic_3366   # Data integration and warehousing
