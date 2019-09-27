class: Workflow
cwlVersion: v1.0
label: >-
  Data2Services CWL workflow to convert XML files, Vincent Emonet
  <vincent.emonet@gmail.com>
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: dataset
    type: string
    'sbg:x': 0
    'sbg:y': 1392.421875
  - id: download_password
    type: string?
    'sbg:x': 0
    'sbg:y': 1285.3125
  - id: download_username
    type: string?
    'sbg:x': 0
    'sbg:y': 1178.203125
  - id: sparql_compute_hcls_path
    type: string
    default: >-
      https://github.com/MaastrichtU-IDS/d2s-transform-repository/tree/master/sparql/compute-hcls-stats
    'sbg:x': 0
    'sbg:y': 1071.09375
  - id: sparql_final_graph_uri
    type: string
    'sbg:x': 0
    'sbg:y': 963.984375
  - id: sparql_final_triplestore_password
    type: string
    'sbg:x': 0
    'sbg:y': 856.875
  - id: sparql_final_triplestore_repository
    type: string
    'sbg:x': 0
    'sbg:y': 749.765625
  - id: sparql_final_triplestore_url
    type: string
    'sbg:x': -476.1847229003906
    'sbg:y': 605.798828125
  - id: sparql_final_triplestore_username
    type: string
    'sbg:x': 0
    'sbg:y': 535.546875
  - id: sparql_insert_metadata_path
    type: string
    'sbg:x': 0
    'sbg:y': 428.4375
  - id: sparql_tmp_graph_uri
    type: string
    'sbg:x': 0
    'sbg:y': 321.328125
  - id: sparql_tmp_service_url
    type: string
    'sbg:x': 0
    'sbg:y': 214.21875
  - id: sparql_tmp_triplestore_repository
    type: string
    'sbg:x': 322.390625
    'sbg:y': 1164.5390625
  - id: sparql_tmp_triplestore_url
    type: string
    'sbg:x': 322.390625
    'sbg:y': 1057.4296875
  - id: sparql_transform_queries_path
    type: string
    'sbg:x': 0
    'sbg:y': 107.109375
  - id: working_directory
    type: string
    'sbg:x': 0
    'sbg:y': 0
outputs:
  - id: download_dataset_logs
    outputSource:
      - step1-d2s-download/download_dataset_logs
    type: File
    'sbg:x': 829.4376220703125
    'sbg:y': 1045.5390625
  - id: execute_sparql_hcls_logs
    outputSource:
      - step6-compute-hcls-stats/execute_sparql_query_logs
    type: File
    'sbg:x': 829.4376220703125
    'sbg:y': 938.4296875
  - id: execute_sparql_metadata_logs
    outputSource:
      - step4-insert-metadata/execute_sparql_query_logs
    type: File
    'sbg:x': 829.4376220703125
    'sbg:y': 831.3203125
  - id: execute_sparql_transform_logs
    outputSource:
      - step5-execute-transform-queries/execute_sparql_query_logs
    type: File
    'sbg:x': 829.4376220703125
    'sbg:y': 724.2109375
  - id: nquads_file_output
    outputSource:
      - step2-xml2rdf/nquads_file_output
    type: File
    'sbg:x': 829.4376220703125
    'sbg:y': 617.1015625
  - id: rdf_upload_logs
    outputSource:
      - step3-rdf-upload/rdf_upload_logs
    type: File
    'sbg:x': 1212.2188720703125
    'sbg:y': 696.2109375
  - id: xml2rdf_file_output
    outputSource:
      - step2-xml2rdf/xml2rdf_file_output
    type: File
    'sbg:x': 829.4376220703125
    'sbg:y': 289.3253479003906
steps:
  - id: step1-d2s-download
    in:
      - id: dataset
        source: dataset
      - id: download_password
        source: download_password
      - id: download_username
        source: download_username
      - id: working_directory
        source: working_directory
    out:
      - id: download_dataset_logs
    run: ../steps/d2s-download.cwl
    label: Download files to process
    'sbg:x': 322.390625
    'sbg:y': 929.3203125
  - id: step2-xml2rdf
    in:
      - id: dataset
        source: dataset
      - id: sparql_tmp_graph_uri
        source: sparql_tmp_graph_uri
      - id: working_directory
        source: working_directory
    out:
      - id: nquads_file_output
      - id: xml2rdf_file_output
    run: ../steps/run-xml2rdf.cwl
    label: Run xml2rdf
    'sbg:x': 326.0675048828125
    'sbg:y': 778.3864135742188
  - id: step3-rdf-upload
    in:
      - id: dataset
        source: dataset
      - id: nquads_file
        source: step2-xml2rdf/nquads_file_output
      - id: sparql_triplestore_repository
        source: sparql_tmp_triplestore_repository
      - id: sparql_triplestore_url
        source: sparql_tmp_triplestore_url
      - id: working_directory
        source: working_directory
    out:
      - id: rdf_upload_logs
    run: ../steps/rdf-upload.cwl
    label: Upload RDF to a SPARQL endpoint
    'sbg:x': 829.4376220703125
    'sbg:y': 481.9921875
  - id: step4-insert-metadata
    in:
      - id: dataset
        source: dataset
      - id: sparql_output_graph_uri
        source: sparql_final_graph_uri
      - id: sparql_password
        source: sparql_final_triplestore_password
      - id: sparql_queries_path
        source: sparql_insert_metadata_path
      - id: sparql_triplestore_repository
        source: sparql_final_triplestore_repository
      - id: sparql_triplestore_url
        source: sparql_final_triplestore_url
      - id: sparql_username
        source: sparql_final_triplestore_username
      - id: working_directory
        source: working_directory
    out:
      - id: execute_sparql_query_logs
    run: ../steps/execute-sparql-mapping.cwl
    label: Execute SPARQL queries
    'sbg:x': 322.390625
    'sbg:y': 617.1015625
  - id: step5-execute-transform-queries
    in:
      - id: dataset
        source: dataset
      - id: sparql_input_graph_uri
        source: sparql_tmp_graph_uri
      - id: sparql_output_graph_uri
        source: sparql_final_graph_uri
      - id: sparql_password
        source: sparql_final_triplestore_password
      - id: sparql_queries_path
        source: sparql_transform_queries_path
      - id: sparql_service_url
        source: sparql_tmp_service_url
      - id: sparql_triplestore_repository
        source: sparql_final_triplestore_repository
      - id: sparql_triplestore_url
        source: sparql_final_triplestore_url
      - id: sparql_username
        source: sparql_final_triplestore_username
      - id: working_directory
        source: working_directory
    out:
      - id: execute_sparql_query_logs
    run: ../steps/execute-sparql-mapping.cwl
    label: Execute SPARQL queries
    'sbg:x': 355.0260009765625
    'sbg:y': 380.01446533203125
  - id: step6-compute-hcls-stats
    in:
      - id: dataset
        source: dataset
      - id: sparql_input_graph_uri
        source: sparql_final_graph_uri
      - id: sparql_password
        source: sparql_final_triplestore_password
      - id: sparql_queries_path
        source: sparql_compute_hcls_path
      - id: sparql_triplestore_repository
        source: sparql_final_triplestore_repository
      - id: sparql_triplestore_url
        source: sparql_final_triplestore_url
      - id: sparql_username
        source: sparql_final_triplestore_username
      - id: working_directory
        source: working_directory
    out:
      - id: execute_sparql_query_logs
    run: ../steps/execute-sparql-mapping.cwl
    label: Execute SPARQL queries
    'sbg:x': 386.50579833984375
    'sbg:y': 144.2112579345703
requirements: []
