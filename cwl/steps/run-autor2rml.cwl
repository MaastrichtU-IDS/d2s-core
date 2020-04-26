#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Run AutoR2RML to generate R2RML mappings
doc: |
    AutoR2RML Docker container to automatically generate R2RML and SPARQL mappings files for SQL databases and tabular files (via Apache Drill). See http://d2s.semanticscience.org/ for more details.

requirements:
  DockerRequirement:
    dockerPull: umids/autor2rml:latest
    dockerOutputDirectory: /data

baseCommand: []
arguments: ["-r", "-o", "/data/mapping.trig", "-d", "/data/$(inputs.dataset_to_process)"]
#  drill should share workspace/input

inputs:
  dataset_to_process:   # Previous step output
    type: string
  input_data_jdbc:
    type: string
    inputBinding:
      position: 1
      prefix: -j


stdout: logs-autor2rml.txt

outputs:
  logs_autor2rml:
    type: stdout
    format: edam:format_1964    # Plain text
  r2rml_trig_file_output:
    type: File
    format: edam:format_3255    # Turtle
    outputBinding:
      glob: mapping.trig
  sparql_mapping_templates:
    type: Directory
    format: edam:format_3790    # SPARQL
    outputBinding:
      glob: sparql_mapping_templates

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

dct:creator:    # Dockstore requirement
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
s:codeRepository: https://github.com/MaastrichtU-IDS/AutoR2RML

edam:has_function:
  - edam:operation_2429   # Mapping
  - edam:operation_1812   # Parsing

edam:has_input: 
  - edam:data_1048 # Database ID

edam:has_output:
  - edam:data_3509    # Ontology mapping

edam:has_topic:
  - edam:topic_0102   # Mapping
  - edam:topic_3489   # Database management
  - edam:topic_3345   # Data identity and mapping

## Extra inputs
# sparql_base_uri:
#   type: string?
#   default: https://w3id.org/d2s/
#   inputBinding:
#     position: 2
#     prefix: -b
# sparql_tmp_graph_uri:
#   type: string?
#   default: https://w3id.org/d2s/graph/autor2rml
#   inputBinding:
#     position: 3
#     prefix: -g
# autor2rml_column_header:
#   type: string?
#   inputBinding:
#     position: 4
#     prefix: -c