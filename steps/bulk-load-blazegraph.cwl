#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Bulk load to Blazegraph
doc: Copy files to a volume shared with the Blazegraph container, then send request to bulk load. See http://d2s.semanticscience.org/ for more details.


baseCommand: [docker, run]

arguments: ["umids/d2s-bash-exec:latest",
# Bash script to copy files in shared volume and send curl:
"https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-cwl-workflows/master/support/blazegraph/blazegraph-bulk-load.sh",
"$(inputs.file_to_load.path)",
"$(inputs.default_graph)"]


inputs:
  file_to_load:
    type: File
  default_graph:
    type: string?
    default: "https://w3id.org/d2s/graph/default"
  previous_step_output:
    type: File?

stdout: logs-blazegraph-bulk-load.txt

outputs:
  logs_blazegraph_bulk_load:
    type: stdout
    format: edam:format_1964    # Plain text


$namespaces:
  s: "http://schema.org/"
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "http://edamontology.org/"
  # Base: https://w3id.org/cwl/cwl#
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