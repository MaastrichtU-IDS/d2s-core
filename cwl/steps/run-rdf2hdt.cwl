#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Run RDFUnit

requirements:
  DockerRequirement:
    dockerPull: rdfhdt/hdt-cpp:latest
    dockerOutputDirectory: /data

baseCommand: ["rdf2hdt"]
arguments: ["$(inputs.input_rdf)", "$(inputs.output_hdt)"]


inputs:
  input_rdf:
    type: File
  output_hdt:
    type: File


stdout: logs-rdf2hdt.txt

outputs:
  rdf2hdt_rdf_output:
    type: Directory
    outputBinding:
      glob: results
  rdf2hdt_logs:
    type: stdout
    format: edam:format_1964    # Plain text

# rdfunit_rdf_output:
  #   type: File
  #   format: edam:format_3256    # N-Triple, no nquads in EDAM
  #   outputBinding:
  #     glob: results/*.ttl


$namespaces:
  s: "http://schema.org/"
  dct: "http://purl.org/dc/terms/"
  foaf: "http://xmlns.com/foaf/0.1/"
  edam: "http://edamontology.org/"
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
s:codeRepository: https://github.com/MaastrichtU-IDS/xml2rdf

# TODO: update edam ontology qualifiers
edam:has_function:
  - edam:operation_3431   # Deposition?

edam:has_input: 
  - edam:format_3256  # N-Triples

edam:has_output:
  - edam:format_2333    # Binary format

edam:has_topic:
  - edam:topic_3372   # Software engineering?