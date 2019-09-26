#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
# requirements:
#   InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/d2s-bash-exec:latest
    dockerOutputDirectory: /data

label: Data2Services tool to download files to process based on Shell scripts, Vincent Emonet <vincent.emonet@gmail.com> 


# baseCommand: [docker, run]
# baseCommand: ["https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-transform-biolink/master/datasets/stitch/download/download-stitch.sh"]
baseCommand: []
arguments: ["$(inputs.download_file)"]

# Use runtime.outdir /input and /output
# arguments: [ "--rm", "-v", "$(inputs.config_dir)/datasets/$(inputs.dataset)/download:/config", 
# "-v" , "$(runtime.outdir)/input:/data", "-v", "$(runtime.outdir)/output:/tmp", 
# "maastrichtuids/d2s-bash-exec:latest", "/config/download.sh"]
# runtime.tmpdir
# https://www.commonwl.org/user_guide/08-arguments/

inputs:
  # in1:
  #   type: File
  #   inputBinding:
  #     position: 1
  #     valueFrom: $(self.basename)

  download_file:
    type: File
  config_dir:
    type: Directory
  dataset:
    type: string
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
