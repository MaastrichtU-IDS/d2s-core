#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: Run AutoR2RML to generate R2RML mappings
# requirements:
#   # Get the config dir as input
#   InitialWorkDirRequirement:
#     listing:
#       - $(inputs.config_dir)
  # InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/autor2rml:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container


# baseCommand: [docker, run]
# arguments: [ "--rm", "--net","d2s-cwl-workflows_d2s-network", 
# "-v" , "$(runtime.outdir):/data", "maastrichtuids/autor2rml:latest", "-r", "-o", "/data/mapping.trig", "-d", "/data"]

baseCommand: []
# arguments: ["-r", "-o", "/data/mapping.trig", "-d", "$(inputs.download_dir)"]
# arguments: ["-r", "-o", "/data/mapping.trig", "-d", "$(runtime.tmpdir)"]

arguments: ["-r", "-o", "/data/mapping.trig", "-d", "/data"]
# TODO: fix AutoR2RML to accept wild card to get a dir?
# TODO: no more full path in rdf:type
# TODO: fix output SPARQL template

inputs:
  dataset:
    type: string
  download_dir:
    type: Directory
  input_data_jdbc:
    type: string
    inputBinding:
      position: 1
      prefix: -j


stdout: autor2rml-logs.txt

outputs:
  r2rml_trig_file_output:
    type: File
    outputBinding:
      glob: mapping.trig
  sparql_mapping_templates:
    type: Directory
    outputBinding:
      glob: sparql_mapping_templates


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