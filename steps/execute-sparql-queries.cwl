#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Execute SPARQL queries

# requirements:
#   # Get the config dir as input
#   InitialWorkDirRequirement:
#     listing:
#       - $(inputs.config_dir)
#   InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/d2s-sparql-operations:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container

baseCommand: []
arguments: []

inputs:
  sparql_queries_path:
    type: string
    inputBinding:
      position: 1
      prefix: -f
  sparql_triplestore_url:
    type: string
    inputBinding:
      position: 2
      prefix: -ep
  sparql_triplestore_repository:
    type: string?
    inputBinding:
      position: 3
      prefix: -rep
  sparql_username:
    type: string?
    inputBinding:
      position: 4
      prefix: -un
  sparql_password:
    type: string?
    inputBinding:
      position: 5
      prefix: -pw
  sparql_input_graph_uri:
    type: string?
    default: "https://w3id.org/data2services/graph/autor2rml"
    inputBinding:
      position: 6
      prefix: --var-input
  sparql_output_graph_uri:
    type: string?
    inputBinding:
      position: 7
      prefix: --var-output
  sparql_service_url:
    type: string?
    inputBinding:
      position: 8
      prefix: --var-service
  previous_step_output:
    type: File?


stdout: execute-sparql-queries-logs.txt

outputs:
  execute_sparql_query_logs:
    type: stdout
    format: edam:format_1964    # Plain text


$namespaces:
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "https://identifiers.org/edam:"
  s: "http://schema.org/"
$schemas:
  - http://xmlns.com/foaf/spec/index.rdf
  - https://lov.linkeddata.es/dataset/lov/vocabs/dcterms/versions/2012-06-14.n3
  - http://edamontology.org/EDAM_1.18.owl
  - http://schema.org/version/latest/schema.rdf

dct:creator:
  "@id": "https://orcid.org/0000-0002-1501-1082"
  foaf:name: "Vincent Emonet"
  foaf:mbox: "mailto:vincent.emonet@gmail.com"

dct:contributor:
  "@id": "https://orcid.org/0000-0000-ammar-ammar"
  foaf:name: "Ammar Ammar"
  foaf:mbox: "mailto:a.ammar@student.maastrichtuniversity.nl"

dct:license: "https://opensource.org/licenses/MIT"
s:citation: "https://swat4hcls.figshare.com/articles/Data2Services_enabling_automated_conversion_of_data_to_services/7345868/files/13573628.pdf"
s:codeRepository: https://github.com/MaastrichtU-IDS/d2s-sparql-operations