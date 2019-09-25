#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

label: Data2Services CWL workflow to convert CSV/TSV files, Vincent Emonet <vincent.emonet@gmail.com> 


inputs: 
  
  working_directory: string 
  dataset: string

  download_username: string?
  download_password: string?

  input_data_jdbc: string

  autor2rml_column_header: string?
  sparql_base_uri: string?
  
  # tmp RDF4J server SPARQL endpoint to load generic RDF
  sparql_tmp_triplestore_url: string
  sparql_tmp_triplestore_repository: string
  sparql_tmp_triplestore_username: string
  sparql_tmp_triplestore_password: string

  sparql_tmp_graph_uri: string
  sparql_tmp_service_url: string

  # Final RDF4J server SPARQL endpoint to load the BioLink RDF
  sparql_final_triplestore_url: string
  sparql_final_triplestore_repository: string
  sparql_final_triplestore_username: string
  sparql_final_triplestore_password: string

  sparql_final_graph_uri: string

  sparql_transform_queries_path: string
  sparql_insert_metadata_path: string
  sparql_compute_hcls_path:
    type: string
    default: https://github.com/MaastrichtU-IDS/d2s-transform-repository/tree/master/sparql/compute-hcls-stats

outputs:
  
  execute_sparql_metadata_logs:
    type: File
    outputSource: step6-insert-metadata/execute_sparql_query_logs
  execute_sparql_transform_logs:
    type: File
    outputSource: step8-execute-transform-queries/execute_sparql_query_logs
  execute_sparql_hcls_logs:
    type: File
    outputSource: step9-compute-hcls-stats/execute_sparql_query_logs

steps:

  step6-insert-metadata:
    run: ../steps/execute-sparql-mapping.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_insert_metadata_path
      sparql_triplestore_url: sparql_final_triplestore_url
      sparql_triplestore_repository: sparql_final_triplestore_repository
      sparql_username: sparql_final_triplestore_username
      sparql_password: sparql_final_triplestore_password
      sparql_output_graph_uri: sparql_final_graph_uri
    out: [execute_sparql_query_logs]

  step8-execute-transform-queries:
    run: ../steps/execute-sparql-mapping.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_transform_queries_path
      sparql_triplestore_url: sparql_final_triplestore_url
      sparql_triplestore_repository: sparql_final_triplestore_repository
      sparql_username: sparql_final_triplestore_username
      sparql_password: sparql_final_triplestore_password
      sparql_input_graph_uri: sparql_tmp_graph_uri
      sparql_output_graph_uri: sparql_final_graph_uri
      sparql_service_url: sparql_tmp_service_url
      previous_step_results: step6-insert-metadata/execute_sparql_query_logs
    out: [execute_sparql_query_logs]

  step9-compute-hcls-stats:
    run: ../steps/execute-sparql-mapping.cwl
    in: # No sparql_queries_path, HCLS stats is the default
      working_directory: working_directory
      dataset: dataset
      sparql_queries_path: sparql_compute_hcls_path
      sparql_triplestore_url: sparql_final_triplestore_url
      sparql_triplestore_repository: sparql_final_triplestore_repository
      sparql_username: sparql_final_triplestore_username
      sparql_password: sparql_final_triplestore_password
      sparql_input_graph_uri: sparql_final_graph_uri
      previous_step_results: step8-execute-transform-queries/execute_sparql_query_logs
    out: [execute_sparql_query_logs]
