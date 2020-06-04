#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
label: Data Quality Assessment pipeline

inputs:
  # Final RDF4J server SPARQL endpoint to load the BioLink RDF
  - id: triplestore_url
    label: "URL of the triplestore SPARQL endpoint to upload RDF to"
    type: string
  - id: triplestore_username
    label: "Username for the triplestore"
    type: string?
  - id: triplestore_password
    label: "Password for the triplestore"
    type: string?
  - id: output_graph_uri
    label: "Graph URI of inserted RDF"
    type: string
  - id: sparql_compute_hcls_path
    label: "URL of queries to compute HCLS stats"
    type: string
    default: https://github.com/MaastrichtU-IDS/d2s-transform-repository/tree/master/sparql/compute-hcls-remote
  - id: analyzed_sparql_endpoint
    label: "URL of the SPARQL endpoint analyzed"
    type: string
  - id: analyzed_graph_uri
    label: "URI of analyzed graph"
    type: string
  - id: rdfunit_schema
    label: "Path to the schema used by RDFUnit"
    type: string
  - id: fairsharing_metrics_url
    label: "URL to the FairSharing page to get metrics"
    type: string

outputs:
  - id: sparql_hcls_statistics_logs
    outputSource: step1-compute-hcls-stats/logs_execute_sparql_query_
    type: File
    label: "SPARQL HCLS statistics log file"
  # - id: rdfunit_rdf_output
  #   outputSource: step2-run-rdfunit/rdfunit_rdf_output
  #   type: Directory
  #   label: "RDFUnit results as RDF"
  # - id: rdfunit_logs
  #   outputSource: step2-run-rdfunit/rdfunit_logs
  #   type: File
  #   label: "RDFUnit log file"
  - id: fairsharing_metrics_rdf_output
    outputSource: step3-run-fairsharing-metrics/fairsharing_metrics_rdf_output
    type: File
    label: "FairSharing metrics file as RDF"
  - id: fairsharing_metrics_logs
    outputSource: step3-run-fairsharing-metrics/fairsharing_metrics_logs
    type: File
    label: "FairSharing metrics log file"
  # - id: upload_rdfunit_logs
  #   outputSource: step4-upload-rdfunit/logs_rdf_upload
  #   type: File
  #   label: "Upload RDFUnit log file"
  - id: upload_fairsharing_metrics_logs
    outputSource: step4-upload-fairsharing-metrics/logs_rdf_upload
    type: File
    label: "Upload FairSharing log file"

steps:
  step1-compute-hcls-stats:
    run: ../steps/execute-sparql-queries-url.cwl
    in: # No sparql_queries_path, HCLS stats is the default
      sparql_queries_path: sparql_compute_hcls_path
      sparql_triplestore_url: triplestore_url
      sparql_username: triplestore_username
      sparql_password: triplestore_password
      sparql_input_graph_uri: analyzed_graph_uri
      sparql_output_graph_uri: output_graph_uri
      sparql_service_url: analyzed_sparql_endpoint
    out: [logs_execute_sparql_query_]

  # step2-run-rdfunit:
  #   run: ../steps/run-rdfunit.cwl
  #   in:
  #     rdfunit_schema: rdfunit_schema
  #     sparql_triplestore_url: analyzed_sparql_endpoint
  #   out: [rdfunit_rdf_output, rdfunit_logs]


  step3-run-fairsharing-metrics:
    run: ../steps/run-fairsharing-metrics.cwl
    in:
      fairsharing_metrics_url: fairsharing_metrics_url
    out: [fairsharing_metrics_rdf_output, fairsharing_metrics_logs]


  # step4-upload-rdfunit:
  #   run: ../steps/rdf-upload-directory.cwl
  #   # run: ../steps/virtuoso-bulk-load.cwl
  #   in:
  #     dir_to_load: step2-run-rdfunit/rdfunit_rdf_output
  #     sparql_triplestore_url: triplestore_url
  #     sparql_username: triplestore_username
  #     sparql_password: triplestore_password
  #     output_graph_uri: output_graph_uri
  #   out: [logs_rdf_upload]


  step4-upload-fairsharing-metrics:
    run: ../steps/rdf-upload.cwl
    # run: ../steps/virtuoso-bulk-load.cwl
    in:
      file_to_load: step3-run-fairsharing-metrics/fairsharing_metrics_rdf_output
      sparql_triplestore_url: triplestore_url
      sparql_username: triplestore_username
      sparql_password: triplestore_password
      output_graph_uri: output_graph_uri
    out: [logs_rdf_upload]




## Workflow metadata
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
s:codeRepository: https://github.com/MaastrichtU-IDS/d2s-core

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