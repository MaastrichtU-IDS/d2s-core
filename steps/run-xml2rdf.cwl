#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Run xml2rdf

# requirements:
#   # Get the config dir as input
#   InitialWorkDirRequirement:
#     listing:
#       - $(inputs.config_dir)
#   InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: maastrichtuids/xml2rdf:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container

baseCommand: []
# arguments: ["-i", "$(inputs.download_dir.path)/*.xml*", "-o", "/tmp/rdf_output.nq",
arguments: ["-i", "$(inputs.download_dir.path)/*.xml", "-o", "$(runtime.outdir)/rdf_output.nq",
"-g", "https://w3id.org/data2services/graph/xml2rdf"]

inputs:
  download_dir:
    type: Directory

stdout: xml2rdf-logs.txt

outputs:
  xml2rdf_logs:
    type: stdout
  xml2rdf_nquads_file_output:
    type: File
    outputBinding:
      glob: rdf_output.nq
  # sparql_mapping_templates:
  #   type: Directory
  #   outputBinding:
  #     glob: sparql_mapping_templates


# arguments: [ "--rm", "-v" , "$(inputs.working_directory):/data", "-v", "$(runtime.outdir):/tmp", 
# "maastrichtuids/xml2rdf:latest", "-i", "/data/input/$(inputs.dataset)/*.xml*", "-o", "/tmp/rdf_output.nq"]
