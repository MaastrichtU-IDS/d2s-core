#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
label: Convert CSV/TSV files to target RDF using Virtuoso

inputs:
  - id: dataset_to_process
    label: "Dataset to process"
    type: string
  - id: config_dir
    label: "CWL config directory"
    type: Directory
  # Final RDF4J server SPARQL endpoint to load the BioLink RDF
  - id: sparql_final_triplestore_url
    label: "URL of final triplestore"
    type: string
  - id: sparql_final_triplestore_username
    label: "Username for final triplestore"
    type: string?
  - id: sparql_final_triplestore_password
    label: "Password for final triplestore"
    type: string?
  - id: sparql_final_graph_uri
    label: "Graph URI of transformed RDF"
    type: string
  - id: sparql_insert_metadata_path
    label: "Path to queries to insert metadata"
    type: string
  - id: sparql_compute_hcls_path
    label: "Path to queries to compute HCLS stats"
    type: string
    default: https://github.com/MaastrichtU-IDS/d2s-transform-repository/tree/master/sparql/compute-hcls-stats
  - id: hcls_metadata_graph_uri
    label: "URI of the HCLS metadata graph"
    type: string
    default: https://w3id.org/d2s/metadata
    

outputs:
  - id: sparql_insert_metadata_logs
    outputSource: step1-insert-metadata/logs_execute_sparql_query_
    type: File
    label: "SPARQL insert metadata log file"
  - id: sparql_hcls_statistics_logs
    outputSource: step2-compute-hcls-stats/logs_execute_sparql_query_
    type: File
    label: "SPARQL HCLS statistics log file"


steps:

  step1-insert-metadata:
    run: ../steps/execute-sparql-queries.cwl
    in:
      config_dir: config_dir
      sparql_queries_path: sparql_insert_metadata_path
      sparql_triplestore_url: sparql_final_triplestore_url
      sparql_username: sparql_final_triplestore_username
      sparql_password: sparql_final_triplestore_password
      sparql_input_graph_uri: sparql_final_graph_uri
      sparql_output_graph_uri: hcls_metadata_graph_uri
      # previous_step_output: step4-rdf-upload/logs_rdf_upload
    out: [logs_execute_sparql_query_]

  step2-compute-hcls-stats:
    run: ../steps/execute-sparql-queries-url.cwl
    in: # No sparql_queries_path, HCLS stats is the default
      # config_dir: config_dir
      sparql_queries_path: sparql_compute_hcls_path
      sparql_triplestore_url: sparql_final_triplestore_url
      sparql_username: sparql_final_triplestore_username
      sparql_password: sparql_final_triplestore_password
      sparql_input_graph_uri: sparql_final_graph_uri
      sparql_output_graph_uri: hcls_metadata_graph_uri
      previous_step_output: step1-insert-metadata/logs_execute_sparql_query_
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
  "@id": "https://orcid.org/0000-0000-ammar-ammar"
  foaf:name: "Ammar Ammar"
  foaf:mbox: "mailto:a.ammar@student.maastrichtuniversity.nl"

dct:license: "https://opensource.org/licenses/MIT"
s:citation: "https://swat4hcls.figshare.com/articles/Data2Services_enabling_automated_conversion_of_data_to_services/7345868/files/13573628.pdf"
s:codeRepository: https://github.com/MaastrichtU-IDS/d2s-cwl-workflows

# TODO: change for annotation/metadata workflow
edam:has_function:
  - edam:operation_1812   # Parsing
  - edam:operation_2429   # Mapping

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