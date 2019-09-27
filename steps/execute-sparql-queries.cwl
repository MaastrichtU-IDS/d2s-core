#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Execute SPARQL queries

# requirements:
#   # Get the config dir as input
#   InitialWorkDirRequirement:
#     listing:
#       - $(inputs.config_dir)
#   InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/d2s-sparql-operations:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container


baseCommand: []
arguments: []

inputs:
  # dataset:
  #   type: string
  sparql_queries_path:
    type: string
    inputBinding:
      position: 1
      prefix: -f
  sparql_triplestore_url:
    type: string
    inputBinding:
      position: 2
      prefix: -ep
  sparql_triplestore_repository:
    type: string?
    inputBinding:
      position: 3
      prefix: -rep
  sparql_username:
    type: string?
    inputBinding:
      position: 4
      prefix: -un
  sparql_password:
    type: string?
    inputBinding:
      position: 5
      prefix: -pw
  sparql_input_graph_uri:
    type: string?
    default: "https://w3id.org/data2services/graph/autor2rml"
    inputBinding:
      position: 6
      prefix: --var-input
  sparql_output_graph_uri:
    type: string?
    inputBinding:
      position: 7
      prefix: --var-output
  sparql_service_url:
    type: string?
    inputBinding:
      position: 8
      prefix: --var-service
  previous_step_output:
    type: File?


stdout: execute-sparql-queries-logs.txt

outputs:
  execute_sparql_query_logs:
    type: stdout


####################

# baseCommand: [docker, run]

# arguments: [ "--rm", "--net", "d2s-cwl-workflows_d2s-network", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
# "maastrichtuids/d2s-sparql-operations:latest" ]
