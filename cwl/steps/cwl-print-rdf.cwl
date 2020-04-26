#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Get RDF metadata for CWL workflow
requirements:
  # InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:    # Get the config dir as input
      - $(inputs.cwl_dir)

#   DockerRequirement:
#     dockerPull: umids/d2s-bash-exec:latest
#     dockerOutputDirectory: /data

baseCommand: ["cwl-runner"]

arguments: ["--print-rdf", "$(inputs.cwl_dir.path)/workflows/$(inputs.cwl_workflow_filename)"]

# baseCommand: []
# arguments: ["cwltool", "--print-rdf", "$(inputs.cwl_dir.path)/workflows/csv-virtuoso.cwl"]

inputs:
  cwl_workflow_filename:
    type: string
  cwl_dir:
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
  previous_step_output:
    type: File?

stdout: cwl-workflows-rdf-description.ttl

outputs:
  cwl_workflow_rdf_description_file:
    type: stdout
    format: edam:format_3255    # Turtle

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
# https://w3id.org/cwl/cwl#

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
  - edam:format_3857        # CWL

edam:has_output:
  - edam:format_2376        # RDF

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