#!/bin/bash

## Download example TSV files from GitHub (COHD clinical data sample)
wget -N https://github.com/MaastrichtU-IDS/d2s-scripts-repository/raw/master/resources/cohd-sample/concepts.tsv
wget -N https://github.com/MaastrichtU-IDS/d2s-scripts-repository/raw/master/resources/cohd-sample/paired_concept_counts_associations.tsv

# Download DrugBank XML
wget -N https://github.com/MaastrichtU-IDS/d2s-scripts-repository/raw/master/resources/drugbank-sample/drugbank.xml

# Download JSON to test RML
https://github.com/MaastrichtU-IDS/d2s-scripts-repository/raw/master/resources/rml-test.json

# Convert TSV to CSV for RML
sed -e 's/"/\\"/g' -e 's/\t/","/g' -e 's/^/"/' -e 's/$/"/'  -e 's/\r//' paired_concept_counts_associations.tsv > paired_concept_counts_associations.csv
