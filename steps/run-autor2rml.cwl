#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: Run AutoR2RML to generate R2RML mappings
doc: |
    AutoR2RML Docker container to automatically generate R2RML and SPARQL mappings files for SQL databases and tabular files (via Apache Drill). See http://d2s.semanticscience.org/ for more details.

# requirements:
#   # Get the config dir as input
#   InitialWorkDirRequirement:
#     listing:
#       - $(inputs.config_dir)
#   InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/autor2rml:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container


baseCommand: []
arguments: ["-r", "-o", "/data/mapping.trig", "-d", "/data"]

inputs:
  download_dir:   # Previous step output
    type: Directory
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


### Annotation documentation
# https://github.com/common-workflow-language/common-workflow-language/blob/master/v1.0/v1.0/metadata.cwl
# https://biotools.readthedocs.io/en/latest/curators_guide.html
# EDAM ontology: https://www.ebi.ac.uk/ols/ontologies/edam

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
# s:dateCreated: "2019-09-27"
# Provided by https://www.commonwl.org/user_guide/17-metadata/

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


# biotools:function:
#   biotools:operation
#   biotools:input:
#     biotools:data
#     biotools:format
#   biotools:output:
#     biotools:data
#     biotools:format
#   biotools:note
#   biotools:cmd    # CommandLine

# Also interesting: SIO ( https://bioportal.bioontology.org/ontologies/SIO/?p=properties )
#  http://semanticscience.org/resource/SIO_000225  sio:has_function
#  http://semanticscience.org/resource/SIO_000217  sio:has_quality
#  http://semanticscience.org/resource/SIO_000228  sio:has_role
#  http://semanticscience.org/resource/SIO_000253  has source
#  http://semanticscience.org/resource/SIO_000362  satisfies


## Extra inputs
# sparql_base_uri:
#   type: string?
#   default: https://w3id.org/data2services/
#   inputBinding:
#     position: 2
#     prefix: -b
# sparql_tmp_graph_uri:
#   type: string?
#   default: https://w3id.org/data2services/graph/autor2rml
#   inputBinding:
#     position: 3
#     prefix: -g
# autor2rml_column_header:
#   type: string?
#   inputBinding:
#     position: 4
#     prefix: -c