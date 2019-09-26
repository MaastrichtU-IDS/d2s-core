#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: Data2Services tool to download files to process based on Shell scripts, Vincent Emonet <vincent.emonet@gmail.com> 
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
