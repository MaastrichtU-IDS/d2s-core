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


stdout: autor2rml-logs.txt

outputs:
  # TODO: add logs as output
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
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "https://identifiers.org/edam:"
  s: "http://schema.org/"
$schemas:
  - http://xmlns.com/foaf/spec/index.rdf
  - https://lov.linkeddata.es/dataset/lov/vocabs/dcterms/versions/2012-06-14.n3
  - http://edamontology.org/EDAM_1.18.owl
  - http://schema.org/version/latest/schema.rdf

# Dockstore requirement
dct:creator:
  "@id": "https://orcid.org/0000-0002-1501-1082"
  foaf:name: "Vincent Emonet"
  foaf:mbox: "mailto:vincent.emonet@gmail.com"

dct:contributor:
  "@id": "https://orcid.org/0000-0000-ammar-ammar"
  foaf:name: "Ammar Ammar"
  foaf:mbox: "mailto:a.ammar@student.maastrichtuniversity.nl"

dct:license: "https://opensource.org/licenses/MIT"
# Provided by https://www.commonwl.org/user_guide/17-metadata/
s:citation: "https://swat4hcls.figshare.com/articles/Data2Services_enabling_automated_conversion_of_data_to_services/7345868/files/13573628.pdf"
s:codeRepository: https://github.com/MaastrichtU-IDS/AutoR2RML
# s:dateCreated: "2019-09-27"


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