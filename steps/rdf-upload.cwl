#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: Upload RDF to SPARQL endpoint
# requirements:
#   # Get the config dir as input
#   InitialWorkDirRequirement:
#     listing:
#       - $(inputs.config_dir)
#   InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/rdf-upload:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container


baseCommand: []
arguments: ["-if", "$(inputs.file_to_load.path)"]

inputs:
  file_to_load:
    type: File
  sparql_triplestore_url:
    type: string
    inputBinding:
      position: 1
      prefix: -url
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

stdout: rdf-upload.txt

outputs:
  rdf_upload_logs:
    type: stdout


      #########################################

# baseCommand: [docker, run]
# arguments: [ "--rm", "--net", "d2s-cwl-workflows_d2s-network", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
# "-v", "$(inputs.nquads_file.path):/tmp/$(inputs.nquads_file.basename)", 
# "maastrichtuids/rdf-upload:latest", "-if", "/tmp/$(inputs.nquads_file.basename)"]


