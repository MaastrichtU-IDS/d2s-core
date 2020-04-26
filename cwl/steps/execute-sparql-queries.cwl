#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Execute SPARQL queries
requirements:
  InlineJavascriptRequirement: {} # TODO: required?
  InitialWorkDirRequirement:
    listing:    # Get the config dir as input
      - $(inputs.config_dir)
  DockerRequirement:
    dockerPull: umids/d2s-sparql-operations:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container

baseCommand: []
arguments: ["-f", "$(inputs.config_dir.path)/$(inputs.sparql_queries_path)"]

inputs:
  config_dir:
    type: Directory
  sparql_queries_path:
    type: string
    # inputBinding:
    #   position: 1
    #   prefix: -f
  sparql_triplestore_url:
    type: string
    inputBinding:
      position: 2
      prefix: -ep
  # TODO: remove?
  # sparql_triplestore_repository:
  #   type: string?
  #   inputBinding:
  #     position: 3
  #     prefix: -rep
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
    default: "https://w3id.org/d2s/graph/autor2rml"
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


stdout: logs-execute-sparql-queries.txt

outputs:
  # TODO: fix var
  logs_execute_sparql_query_:
    type: stdout
    format: edam:format_1964    # Plain text


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

dct:license: "https://opensource.org/licenses/MIT"
s:citation: "https://swat4hcls.figshare.com/articles/Data2Services_enabling_automated_conversion_of_data_to_services/7345868/files/13573628.pdf"
s:codeRepository: https://github.com/MaastrichtU-IDS/d2s-sparql-operations

edam:has_function:
  - edam:operation_0224   # Query and retrieval

edam:has_input: 
  - edam:format_3790 # SPARQL

edam:has_output:
  - edam:format_2376    # RDF format

edam:has_topic:
  - edam:topic_0219   # Data submission, annotation and curation
  - edam:topic_3366   # Data integration and warehousing
  - edam:topic_3365   # Data architecture, analysis and design

# TODO: get warning 'unrecognized extension field http://commonwl.org/cwltool#generation'