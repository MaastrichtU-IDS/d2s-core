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

# baseCommand: ["https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-transform-biolink/master/datasets/stitch/download/download-stitch.sh"]
baseCommand: []
arguments: ["$(runtime.outdir)/$(inputs.dataset)/download/download.sh"]

# https://www.commonwl.org/user_guide/08-arguments/

inputs:
  dataset:
    type: string
  config_dir:
    type: Directory
  download_username:
    type: string?
    inputBinding:
      position: 1
      prefix: --username
  download_password:
    type: string?
    inputBinding:
      position: 2
      prefix: --password


stdout: download-dataset.txt

outputs:
  download_dataset_logs:
    type: stdout
  download_dir:
    type: Directory
    outputBinding:
      glob: .



#################

arguments: [ "--rm", "--net", "d2s-cwl-workflows_d2s-network", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
"maastrichtuids/autor2rml:latest", "-r", "-o", "/tmp/mapping.trig", "-d", "/data/input/$(inputs.dataset)"]

requirements:
  EnvVarRequirement:
    envDef:
      HOME: $(inputs.working_directory)

inputs:
  
  working_directory:
    type: string
  dataset:
    type: string
  input_data_jdbc:
    type: string
    inputBinding:
      position: 1
      prefix: -j
  sparql_base_uri:
    type: string?
    default: https://w3id.org/data2services/
    inputBinding:
      position: 2
      prefix: -b
  sparql_tmp_graph_uri:
    type: string?
    default: https://w3id.org/data2services/graph/autor2rml
    inputBinding:
      position: 3
      prefix: -g
  autor2rml_column_header:
    type: string?
    inputBinding:
      position: 4
      prefix: -c
  previous_step_results:
    type: File?

outputs:
  
  r2rml_trig_file_output:
    type: File
    outputBinding:
      glob: mapping.trig

