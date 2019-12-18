#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
label: Data Quality Assessment pipeline

inputs:
  # Final RDF4J server SPARQL endpoint to load the BioLink RDF
  - id: triplestore_url
    label: "URL of the triplestore SPARQL endpoint"
    type: string
  - id: triplestore_username
    label: "Username for the triplestore"
    type: string?
  - id: triplestore_password
    label: "Password for the triplestore"
    type: string?
  - id: graph_uri
    label: "Graph URI of inserted RDF"
    type: string
  - id: sparql_compute_hcls_path
    label: "Path to queries to compute HCLS stats"
    type: string
    default: https://github.com/MaastrichtU-IDS/d2s-transform-repository/tree/master/sparql/compute-hcls-stats


outputs:
  - id: sparql_hcls_statistics_logs
    outputSource: step7-compute-hcls-stats/logs_execute_sparql_query_
    type: File
    label: "SPARQL HCLS statistics log file"


steps:

  step1-compute-hcls-stats:
    run: ../steps/execute-sparql-queries-url.cwl
    in: # No sparql_queries_path, HCLS stats is the default
      sparql_queries_path: sparql_compute_hcls_path
      sparql_triplestore_url: triplestore_url
      sparql_username: triplestore_username
      sparql_password: triplestore_password
      sparql_input_graph_uri: graph_uri
    out: [logs_execute_sparql_query_]


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
  "@id": "https://orcid.org/0000-0000-jinzhou-yang"
  foaf:name: "Jinzhou Yang"
  foaf:mbox: "mailto:j.yang@maastrichtuniversity.nl"

dct:license: "https://opensource.org/licenses/MIT"
# s:citation: "https://swat4hcls.figshare.com/articles/Data2Services_enabling_automated_conversion_of_data_to_services/7345868/files/13573628.pdf"
s:codeRepository: https://github.com/MaastrichtU-IDS/d2s-cwl-workflows

edam:has_function:
  - edam:operation_2429   # Mapping
  - edam:operation_1812   # Parsing

edam:has_input: 
  - edam:data_3786      # Query script
  - edam:format_3857    # CWL
  - edam:format_3790    # SPARQL

edam:has_output:
  - edam:format_2376    # RDF format
  - edam:data_3509      # Ontology mapping

edam:has_topic:
  - edam:topic_0769   # Workflows
  - edam:topic_0219   # Data submission, annotation and curation
  - edam:topic_0102   # Mapping
  - edam:topic_3345   # Data identity and mapping