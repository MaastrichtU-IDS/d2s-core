#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Split RDF statements
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
arguments: [ "-op", "split", "--split-delete" ]

# arguments: [ "--rm", "--net","d2s-cwl-workflows_d2s-network", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
# "maastrichtuids/d2s-sparql-operations:latest", "-op", "split", "--split-delete" ]

inputs:

  sparql_triplestore_url:
    type: string
    inputBinding:
      position: 1
      prefix: -ep
  sparql_username:
    type: string?
    inputBinding:
      position: 2
      prefix: -un
  sparql_password:
    type: string?
    inputBinding:
      position: 3
      prefix: -pw
  split_property:
    type: string
    inputBinding:
      position: 4
      prefix: --split-property
  split_class:
    type: string
    inputBinding:
      position: 5
      prefix: --split-class
  split_delimiter:
    type: string
    inputBinding:
      position: 6
      prefix: --split-delimiter
  split_quote:
    type: string?
    inputBinding:
      position: 7
      prefix: --split-quote

stdout: execute-split-logs.txt

outputs:
  execute_split_logs:
    type: stdout
