#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Download files to process
requirements:
  # Get the config dir as input
  InitialWorkDirRequirement:
    listing:
      - $(inputs.config_dir)
  # InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/d2s-bash-exec:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container

baseCommand: []
# arguments: ["$(inputs.config_dir.path)/download/download.sh", "input"] 
arguments: ["$(runtime.outdir)/$(inputs.dataset)/download/download.sh", "input"]

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
      glob: input