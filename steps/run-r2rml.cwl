#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: Run R2RML
# requirements:
#   # Get the config dir as input
#   InitialWorkDirRequirement:
#     listing:
#       - $(inputs.config_dir)
  # InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/r2rml:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container


baseCommand: []

arguments: [ "--connectionURL", "$(inputs.input_data_jdbc)",
"--mappingFile", "$(inputs.r2rml_trig_file)", 
"--outputFile", "$(runtime.outdir)/rdf_output.nq", 
"--format", "NQUADS" ]

inputs:
  r2rml_trig_file:
    type: File 
  input_data_jdbc:
    type: string

stdout: r2rml-logs.txt

outputs:
  r2rml_nquads_file_output:
    type: File
    outputBinding:
      glob: rdf_output.nq
  r2rml_logs:
    type: stdout

#########################

# baseCommand: [docker, run]
# arguments: [ "--rm", "--net","d2s-cwl-workflows_d2s-network", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
# "-v", "$(inputs.r2rml_config_file.path):/tmp/$(inputs.r2rml_config_file.basename)", 
# "-v", "$(inputs.r2rml_trig_file.path):/tmp/$(inputs.r2rml_trig_file.basename)", 
# "maastrichtuids/r2rml:latest", "/tmp/$(inputs.r2rml_config_file.basename)" ]
