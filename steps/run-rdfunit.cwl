#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: Run RDFUnit

hints:
  DockerRequirement:
    dockerPull: umids/rdfunit:latest
    dockerOutputDirectory: /data

# Official image has issue due to using relative path as Dockerfile entrypoint
# dockerPull: aksw/rdfunit:latest

# Test it:
# docker run --rm -i -v /data/dqa-workspace/:/data aksw/rdfunit:latest -d "http://sparql.wikipathways.org/" -f /data/ -s "https://www.w3.org/2012/pyRdfa/extract?uri=http://vocabularies.wikipathways.org/wp#" -o ttl

baseCommand: []
# arguments: ["-d", "$(inputs.sparql_triplestore_url)",
# "-f", "/data/", "-s", "$(inputs.rdfunit_schema)", "-o", "ttl"]

arguments: ["-d", "http://sparql.wikipathways.org/sparql",
"-f", "/data", 
"-s", "https://www.w3.org/2012/pyRdfa/extract?uri=http://vocabularies.wikipathways.org/wp#", 
"-o", "ttl"]

inputs:
  sparql_triplestore_url:
    type: string
  rdfunit_schema:
    type: string
    # -sch https://www.w3.org/2012/pyRdfa/extract?uri=http://vocabularies.wikipathways.org/wp# \


stdout: logs-rdfunit.txt

outputs:
  # rdfunit_rdf_output:
  #   type: File
  #   format: edam:format_3256    # N-Triple, no nquads in EDAM
  #   outputBinding:
  #     glob: "results/*.ttl"
  rdfunit_rdf_output:
    type: Directory
    outputBinding:
      glob: results
  rdfunit_logs:
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