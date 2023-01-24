#!/bin/bash

## plot

genes=./data/gene_list.txt

for gene in $(cat ${genes}); do

input=./output/data_source/ms2_tpm_${gene}.txt

Rscript ./code/tpm_plot_ms2.R ${input} ${gene}

done

