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
arguments: ["$(inputs.config_dir.path)/download/download.sh", "input"]

inputs:
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
    format: edam:format_1964    # Plain text
  download_dir:
    type: Directory
    outputBinding:
      glob: input

$namespaces:
  s: "http://schema.org/"
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "http://edamontology.org/"
$schemas:
  - http://schema.org/version/latest/schema.rdf
  - https://lov.linkeddata.es/dataset/lov/vocabs/dcterms/versions/2012-06-14.n3
  - http://xmlns.com/foaf/spec/index.rdf
  - http://edamontology.org/EDAM_1.18.owl

dct:creator:
  class: foaf:Person
  "@id": "https://orcid.org/0000-0002-1501-1082"
  foaf:name: "Vincent Emonet"
  foaf:mbox: "mailto:vincent.emonet@gmail.com"

dct:contributor:
  class: foaf:Person
  "@id": "https://orcid.org/0000-0000-ammar-ammar"
  foaf:name: "Ammar Ammar"
  foaf:mbox: "mailto:a.ammar@student.maastrichtuniversity.nl"

dct:license: "https://opensource.org/licenses/MIT"
s:citation: "https://swat4hcls.figshare.com/articles/Data2Services_enabling_automated_conversion_of_data_to_services/7345868/files/13573628.pdf"
s:codeRepository: https://github.com/MaastrichtU-IDS/d2s-bash-exec