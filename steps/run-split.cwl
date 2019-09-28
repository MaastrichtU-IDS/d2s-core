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
    dockerPull: maastrichtuids/d2s-sparql-operations:latest
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
  previous_step_output:
    type: File?

stdout: execute-split-logs.txt

outputs:
  execute_split_logs:
    type: stdout
    format: edam:format_1964    # Plain text

$namespaces:
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "https://identifiers.org/edam:"
  s: "http://schema.org/"
$schemas:
  - http://xmlns.com/foaf/spec/index.rdf
  - https://lov.linkeddata.es/dataset/lov/vocabs/dcterms/versions/2012-06-14.n3
  - http://edamontology.org/EDAM_1.18.owl
  - http://schema.org/version/latest/schema.rdf

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
s:codeRepository: https://github.com/MaastrichtU-IDS/d2s-sparql-operations