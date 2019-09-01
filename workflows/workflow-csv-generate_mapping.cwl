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
  sparql_tmp_graph_uri: string?

  sparql_triplestore_url: string
  sparql_triplestore_repository: string

  sparql_username: string?
  sparql_password: string?
  sparql_output_graph_uri: string
  sparql_service_url: string

  # We could output the template SPARQL mappings directly in mapping folder, but risk of overwriting old files
  # sparql_transform_queries_path: string
outputs:
  
  download_dataset_logs:
    type: File
    outputSource: step1-d2s-download/download_dataset_logs
  r2rml_trig_file_output:
    type: File
    outputSource: step2-autor2rml/r2rml_trig_file_output
  r2rml_config_file_output:
    type: File
    outputSource: step3-generate-r2rml-config/r2rml_config_file_output
  nquads_file_output:
    type: File
    outputSource: step4-r2rml/nquads_file_output
  rdf_upload_logs:
    type: File
    outputSource: step5-rdf-upload/rdf_upload_logs

steps:

  step1-d2s-download:
    run: ../steps/d2s-download.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      download_username: download_username
      download_password: download_password
    out: [download_dataset_logs]

  step2-autor2rml:
    run: ../steps/autor2rml.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      input_data_jdbc: input_data_jdbc
      autor2rml_column_header: autor2rml_column_header
      sparql_base_uri: sparql_base_uri
      sparql_tmp_graph_uri: sparql_tmp_graph_uri
      previous_step_results: step1-d2s-download/download_dataset_logs
    out: [r2rml_trig_file_output]

  step3-generate-r2rml-config:
    run: ../steps/generate-r2rml-config.cwl
    in:
      dataset: dataset
      input_data_jdbc: input_data_jdbc
      r2rml_trig_file: step2-autor2rml/r2rml_trig_file_output
    out: [r2rml_config_file_output]

  step4-r2rml:
    run: ../steps/run-r2rml.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      r2rml_trig_file: step2-autor2rml/r2rml_trig_file_output
      r2rml_config_file: step3-generate-r2rml-config/r2rml_config_file_output
    out: [nquads_file_output]

  step5-rdf-upload:
    run: ../steps/rdf-upload.cwl
    in:
      working_directory: working_directory
      dataset: dataset
      nquads_file: step4-r2rml/nquads_file_output
      sparql_triplestore_url: sparql_triplestore_url
      sparql_triplestore_repository: sparql_triplestore_repository
    out: [rdf_upload_logs]
