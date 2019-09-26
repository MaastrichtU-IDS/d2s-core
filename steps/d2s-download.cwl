#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: Data2Services tool to download files to process based on Shell scripts, Vincent Emonet <vincent.emonet@gmail.com> 
# DEPRECATED, use d2s-bash-exec instead

baseCommand: [docker, run]

# Use runtime.outdir /input and /output
arguments: [ "--rm", "-v" , "$(runtime.outdir)/input:/data", "-v", "$(runtime.outdir)/output:/tmp", 
"maastrichtuids/d2s-download:latest", "--download-datasets", "$(inputs.dataset)"]
# runtime.tmpdir
# https://www.commonwl.org/user_guide/08-arguments/
inputs:
  
  working_directory:
    type: string
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
