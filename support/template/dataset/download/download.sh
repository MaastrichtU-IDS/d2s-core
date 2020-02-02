#!/bin/bash

## Download example TSV files from GitHub (COHD clinical data)

wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-transform-template/master/datasets/cohd/download/cohd-sample/concepts.tsv
wget -N https://raw.githubusercontent.com/MaastrichtU-IDS/d2s-transform-template/master/datasets/cohd/download/cohd-sample/paired_concept_counts_associations.tsv
