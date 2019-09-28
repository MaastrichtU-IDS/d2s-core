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
    format: edam:format_3256    # N-Triple, no nquads in EDAM
    outputBinding:
      glob: rdf_output.nq
  r2rml_logs:
    type: stdout

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
s:codeRepository: https://github.com/MaastrichtU-IDS/r2rml

edam:has_function:
  - edam:operation_2429   # Mapping
  - edam:operation_1812   # Parsing

edam:has_input: 
  - edam:data_1048    # Database ID
  - edam:data_3509    # Ontology mapping

edam:has_output:
  - edam:format_3256    # N-Triples, no nquads

edam:has_topic:
  - edam:topic_0102   # Mapping
  - edam:topic_3345   # Data identity and mapping