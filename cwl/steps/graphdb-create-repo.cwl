#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Create GraphDB repository
doc: Docker container to automatically execute Bash script from files and URLs. See http://d2s.semanticscience.org/ for more details.
requirements:
  # InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:    # Get the config dir as input
      - $(inputs.cwl_dir)
  DockerRequirement:
    dockerPull: umids/d2s-bash-exec:latest
    dockerOutputDirectory: /data
    # Link the output dir to /data in the Docker container

baseCommand: []
arguments: ["$(inputs.cwl_dir.path)/support/graphdb_create_repo.sh"]

inputs:
  cwl_dir:
    type: Directory
  sparql_triplestore_url:
    type: string?
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
  previous_step_output:
    type: File?

stdout: logs-create-graphdb-repo.txt

outputs:
  logs_create_graphdb_repo:
    type: stdout
    format: edam:format_1964    # Plain text

$namespaces:
  s: "http://schema.org/"
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "http://edamontology.org/"
  # Base: https://w3id.org/cwl/cwl#
$schemas:
  - https://schema.org/version/latest/schemaorg-current-http.rdf
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
# s:dateCreated: "2019-09-27"

edam:has_function:
  - edam:operation_2422   # Data retrieval

edam:has_input: 
  - edam:data_3786        # Query script

edam:has_output:
  - edam:data_2526        # Text data

edam:has_topic:
  - edam:topic_3077       # Data acquisition

### Annotation documentation
# CWL doc: https://www.commonwl.org/user_guide/17-metadata/
# https://github.com/common-workflow-language/common-workflow-language/blob/master/v1.0/v1.0/metadata.cwl
# https://biotools.readthedocs.io/en/latest/curators_guide.html
# EDAM ontology: https://www.ebi.ac.uk/ols/ontologies/edam

# biotools:function:
#   biotools:operation
#   biotools:input:
#     biotools:data
#     biotools:format
#   biotools:output:
#     biotools:data
#     biotools:format
#   biotools:note
#   biotools:cmd    # CommandLine