#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
label: Convert CSV/TSV files to a target RDF

inputs:   
  - id: dataset
    label: "Dataset name"
    type: string
  - id: config_dir
    label: "CWL config directory"
    type: Directory
  - id: download_username
    label: "Username to download files"
    type: string?
  - id: download_password
    label: "Password to download files"
    type: string?
  - id: input_data_jdbc
    label: "JDBC URL for database connexion"
    type: string

  # - id: download_file
  #   label: "Input files download script path"
  #   type: File

  # autor2rml_column_header: string?
  # sparql_base_uri: string?
  
  # # tmp RDF4J server SPARQL endpoint to load generic RDF
  # sparql_tmp_triplestore_url: string
  # sparql_tmp_triplestore_repository: string?
  # sparql_tmp_triplestore_username: string?
  # sparql_tmp_triplestore_password: string?

  # sparql_tmp_graph_uri: string
  # sparql_tmp_service_url: string

  # # Final RDF4J server SPARQL endpoint to load the BioLink RDF
  # sparql_final_triplestore_url: string
  # sparql_final_triplestore_repository: string?
  # sparql_final_triplestore_username: string?
  # sparql_final_triplestore_password: string?

  # sparql_final_graph_uri: string

  # # sparql_transform_queries_path: string
  # # sparql_insert_metadata_path: string
  # sparql_compute_hcls_path:
  #   type: string
  #   default: https://github.com/MaastrichtU-IDS/d2s-transform-repository/tree/master/sparql/compute-hcls-stats

outputs:
  - id: download_dir
    outputSource: step1-d2s-download/download_dir
    type: Directory
    label: "Downloaded files"
  - id: download_dataset_logs
    outputSource: step1-d2s-download/download_dataset_logs
    type: File
    label: "Download execution logs"
  - id: r2rml_trig_file_output
    outputSource: step2-autor2rml/r2rml_trig_file_output
    type: File
    label: "AutoR2RML execution logs"
  - id: sparql_mapping_templates
    outputSource: step2-autor2rml/sparql_mapping_templates
    type: Directory
    label: "SPARQL mapping templates files"
  - id: r2rml_config_file_output
    outputSource: step3-generate-r2rml-config/r2rml_config_file_output
    type: File
    label: "SPARQL mapping templates files"


  # nquads_file_output:
  #   type: File
  #   outputSource: step4-r2rml/nquads_file_output
  # rdf_upload_logs:
  #   type: File
  #   outputSource: step5-rdf-upload/rdf_upload_logs
  # execute_sparql_metadata_logs:
  #   type: File
  #   outputSource: step6-insert-metadata/execute_sparql_query_logs
  # execute_sparql_transform_logs:
  #   type: File
  #   outputSource: step8-execute-transform-queries/execute_sparql_query_logs
  # execute_sparql_hcls_logs:
  #   type: File
  #   outputSource: step9-compute-hcls-stats/execute_sparql_query_logs

steps:

  step1-d2s-download:
    run: ../steps/d2s-bash-exec.cwl
    in:
      dataset: dataset
      config_dir: config_dir
      download_username: download_username
      download_password: download_password
    out: [download_dir, download_dataset_logs]

  step2-autor2rml:
    run: ../steps/autor2rml.cwl
    in:
      download_dir: step1-d2s-download/download_dir
      dataset: dataset
      input_data_jdbc: input_data_jdbc
    out: [r2rml_trig_file_output, sparql_mapping_templates]

  step3-generate-r2rml-config:
    run: ../steps/generate-r2rml-config.cwl
    in:
      dataset: dataset
      input_data_jdbc: input_data_jdbc
      r2rml_trig_file: step2-autor2rml/r2rml_trig_file_output
    out: [r2rml_config_file_output]

  # step4-r2rml:
  #   run: ../steps/run-r2rml.cwl
  #   in:
  #     working_directory: working_directory
  #     dataset: dataset
  #     r2rml_trig_file: step2-autor2rml/r2rml_trig_file_output
  #     r2rml_config_file: step3-generate-r2rml-config/r2rml_config_file_output
  #   out: [nquads_file_output]

  # step5-rdf-upload:
  #   # run: ../steps/rdf-upload.cwl
  #   run: ../steps/virtuoso-bulk-load.cwl
  #   in:
  #     working_directory: working_directory
  #     dataset: dataset
  #     nquads_file: step4-r2rml/nquads_file_output
  #     sparql_triplestore_url: sparql_tmp_triplestore_url
  #     sparql_triplestore_repository: sparql_tmp_triplestore_repository
  #     sparql_username: sparql_tmp_triplestore_username
  #     sparql_password: sparql_tmp_triplestore_password
  #   out: [rdf_upload_logs]

  # step6-insert-metadata:
  #   run: ../steps/execute-sparql-mapping.cwl
  #   in:
  #     working_directory: working_directory
  #     dataset: dataset
  #     sparql_queries_path: sparql_insert_metadata_path
  #     sparql_triplestore_url: sparql_final_triplestore_url
  #     sparql_triplestore_repository: sparql_final_triplestore_repository
  #     sparql_username: sparql_final_triplestore_username
  #     sparql_password: sparql_final_triplestore_password
  #     sparql_output_graph_uri: sparql_final_graph_uri
  #     previous_step_results: step5-rdf-upload/rdf_upload_logs
  #   out: [execute_sparql_query_logs]

  # step8-execute-transform-queries:
  #   run: ../steps/execute-sparql-mapping.cwl
  #   in:
  #     working_directory: working_directory
  #     dataset: dataset
  #     sparql_queries_path: sparql_transform_queries_path
  #     sparql_triplestore_url: sparql_final_triplestore_url
  #     sparql_triplestore_repository: sparql_final_triplestore_repository
  #     sparql_username: sparql_final_triplestore_username
  #     sparql_password: sparql_final_triplestore_password
  #     sparql_input_graph_uri: sparql_tmp_graph_uri
  #     sparql_output_graph_uri: sparql_final_graph_uri
  #     sparql_service_url: sparql_tmp_service_url
  #     previous_step_results: step5-rdf-upload/rdf_upload_logs
  #   out: [execute_sparql_query_logs]

  # step9-compute-hcls-stats:
  #   run: ../steps/execute-sparql-mapping.cwl
  #   in: # No sparql_queries_path, HCLS stats is the default
  #     working_directory: working_directory
  #     dataset: dataset
  #     sparql_queries_path: sparql_compute_hcls_path
  #     sparql_triplestore_url: sparql_final_triplestore_url
  #     sparql_triplestore_repository: sparql_final_triplestore_repository
  #     sparql_username: sparql_final_triplestore_username
  #     sparql_password: sparql_final_triplestore_password
  #     sparql_input_graph_uri: sparql_final_graph_uri
  #     previous_step_results: step8-execute-transform-queries/execute_sparql_query_logs
  #   out: [execute_sparql_query_logs]
