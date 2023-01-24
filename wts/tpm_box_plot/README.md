## Make boxplots using RNA-seq TPM

0. Working place  
    ```
    cd ./box_plot/
    ```

1. Preparation  
The matrix of TPM for each cancer type. The rows present genes and the columns present samples. 
In the previous step, we select genes of level 1 and 2 in gencode.v39.  
Place: ../prep/output/ms2_*_tpm.txt   
Format:  
Gene _tab_ Sample1 _tab_ Sample2 .....  
GeneA  _tab_  TPM1  _tab_ TPM2  .....

2. Make a data file for each gene.   
Make a gene list, ./data/gene_list.txt.  
Format:  
GeneA  
GeneB  
:    
If you make plots for all genes, use  cut command like following a sentence.  
Output: ./output/data_source  
    ```
    cut -f1 ../prep/output/ms2_AAC_tpm.txt | grep -v 'Gene' > ./data/gene_list.txt

    run1.sh
    ```

3. Make plots
Use a gene list, ./data/gene_list.txt.  
Format:  
GeneA  
GeneB  
:    
Output: ./output/figure  
    ```
    run2.sh
    ```

