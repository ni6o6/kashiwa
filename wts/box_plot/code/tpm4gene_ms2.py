#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov 24 13:27:10 2022

@author: Naoko Iida
"""

def tmp4gene_tcga(output_file, gene):
    
    import glob
    
    #l = glob.glob('../../../TCGA/star-counts/merge/*.tsv')
    #local
    l = glob.glob('../prep/output/*tpm.txt')    
    with open(output_file, 'w') as hout:
        header = "Cancer_type\tSample\tTPM\n"
        hout.write(header)
        for file in l:
            file_name = file.split('/')[-1]
            cancer_type = file_name.split('_')[1]
            with open(file, 'r') as hin:
                H = hin.readline().rstrip('\n').split("\t")
                for line in hin:
                    F = line.rstrip('\n').split('\t')
                    if F[0] == gene:
                        for i in range(1,len(F)):
                            val = F[i]
                            sample = H[i]
                            rec = cancer_type +"\t"+ sample +"\t"+ val + "\n"
                            hout.write(rec)

if __name__ == "__main__":
    from argparse import ArgumentParser

    parser = ArgumentParser()
    parser.add_argument("-output_file", action="store", dest="output_file", help="output file", required=True)
    parser.add_argument("-gene", action="store", dest="gene", help="gene", required=True)
    o = parser.parse_args()

    tmp4gene_tcga(o.output_file, o.gene)

