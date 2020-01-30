#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Run xml2rdf

requirements:
  DockerRequirement:
    dockerPull: umids/xml2rdf:latest
    dockerOutputDirectory: /data
  # InitialWorkDirRequirement:
  #   listing:    # Get the config dir as input
  #     - $(inputs.dir_to_process)

baseCommand: []
arguments: ["-i", "$(inputs.dir_to_process.path)/*.xml", "-o", "$(runtime.outdir)/rdf_output.nq",
"-g", "https://w3id.org/d2s/graph/xml2rdf"]

inputs:
  # dataset_to_process:
  #   type: string
  dir_to_process:
    type: Directory
    # path: "../../datasets/workspace/input/$(inputs.dataset_to_process)"
    # format: edam:format_2332    # XML (validation exception because finds .zip)
  # TODO: add graph URI input


stdout: logs-xml2rdf.txt

outputs:
  logs_xml2rdf:
    type: stdout
    format: edam:format_1964    # Plain text
  xml2rdf_nquads_file_output:
    type: File
    format: edam:format_3256    # N-Triple, no nquads in EDAM
    outputBinding:
      glob: rdf_output.nq
  sparql_mapping_templates:
    type: Directory
    outputBinding:
      glob: sparql_mapping_templates

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
s:codeRepository: https://github.com/MaastrichtU-IDS/xml2rdf

edam:has_function:
  - edam:operation_2429   # Mapping
  - edam:operation_1812   # Parsing

edam:has_input: 
  - edam:format_2332    # XML

edam:has_output:
  - edam:format_3256    # N-Triples, no nquads
  - edam:data_3509    # Ontology mapping

edam:has_topic:
  - edam:topic_0102   # Mapping
  - edam:topic_3345   # Data identity and mapping