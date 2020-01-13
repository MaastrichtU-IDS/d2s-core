#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Upload RDF to SPARQL endpoint

hints:
  DockerRequirement:
    dockerPull: umids/rdf-upload:latest
    dockerOutputDirectory: /data

baseCommand: []
arguments: ["-if", "$(inputs.file_to_load.path)"]

inputs:
  file_to_load:
    type: File
    format: edam:format_2376    # RDF format
    # format: 
    # - edam:format_3256    # N-Triple, no nquads in EDAM
    # - edam:formart_3255    # Turtle
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
  output_graph_uri:
    type: string?
    inputBinding:
      position: 4
      prefix: -g
  previous_step_output:
    type: File?

stdout: logs-rdfupload.txt

outputs:
  logs_rdf_upload:
    type: stdout
    format: edam:format_1964    # Plain text



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
s:codeRepository: https://github.com/MaastrichtU-IDS/RdfUpload

edam:has_function:
  - edam:operation_3436   # Aggregation

edam:has_input: 
  - edam:format_3256    # N-Triples, no nquads

edam:has_output:
  - edam:format_2376    # RDF format
  - edam:data_0954      # Database cross-mapping

edam:has_topic:
  - edam:topic_3366   # Data integration and warehousing
