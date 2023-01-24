#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 11 10:50:10 2022

@author: Naoko Iida
"""

def make_matrix_tpm(path_to_dir, output_file, gene_file):

    import glob
    import pandas as pd
        
    l = glob.glob(path_to_dir+"/*.rna_seq.augmented_star_gene_counts.tsv")
    
    df0 = pd.read_table(gene_file, header=None , names=['Gene'])
    
    for file in l:
        print(file)
        file_name = file.split('/')[-1]
        sample_id = file_name.split('.')[0]
        I = sample_id.split('-')
        # select cancer
        if I[3][0:2] in ["01","02","03","04","05","06","07","08","09"]:
            df = pd.read_table(file , usecols=[1,6],skiprows=1, header=0 , names=("Gene", sample_id))
            df_rm = df.drop_duplicates(subset=["Gene"], keep=False)
        
            df0 = pd.merge(df0, df_rm, on='Gene', how='left')
         
    df0.to_csv(output_file,sep="\t",index=False)

    
if __name__ == "__main__":
    from argparse import ArgumentParser

    parser = ArgumentParser()
    parser.add_argument("-path_to_dir", action="store", dest="path_to_dir", help="path to directory of sample.tpm.tsv", required=True)
    parser.add_argument("-gene_file", action="store", dest="gene_file", help="gene file", required=True)
    parser.add_argument("-output_file", action="store", dest="output_file", help="output file", required=True)
    o = parser.parse_args()

    make_matrix_tpm(o.path_to_dir, o.output_file, o.gene_file)
    

    
