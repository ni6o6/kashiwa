#$ -S /bin/bash
#$ -cwd -V
#$ -pe def_slot 1
#$ -l s_vmem=4G


#cut -f1 ../prep/output/ms2_AAC_tpm.txt | grep -v 'Gene' > ./data/gene_list.txt

genes=./data/gene_list.txt

for gene in $(cat ${genes}); do

echo ${gene}

output_file=./output/data_source/ms2_tpm_${gene}.txt

python3 ./code/tpm4gene_ms2.py -gene ${gene} -output_file ${output_file}


done

