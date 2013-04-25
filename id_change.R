###################################################
###
### Objective: convert RefSeq mRNA id into entrez id and gene symbol
###            
### Author: Xiaoqin Yang @Tongji University 
###
### Email: sirxqyang@gmail.com
###
### Date: 25th April, 2013
###
### Note: No reproduction or republication without permission.
###
###################################################


###################################################
### code chunk number 0: load the data you need
###################################################
setwd("~/Desktop/lidan_id_change/rawdata")
Rawdata <- read.table("example.rtf", header = FALSE)
colnames(Rawdata) <- c('refseq_mrna', 'GFOLD', 'E-FDR', 'log2fdc', '1stRPKM', '2ndRPKM')
refseqids = Rawdata[,1]


###################################################
### code chunk number 1: load the library biomaRt 
###################################################
library('biomaRt')


###################################################
### code chunk number 2: ensembl1 
### Connects to the selected BioMart database and dataset
###################################################
ensembl = useMart("ensembl")


###################################################
### code chunk number 3: ensembl2 
### choose the dataset
###################################################
ensembl = useDataset("hsapiens_gene_ensembl",mart=ensembl)


###################################################
### code chunk number 4: ensembl2 
### Retrieves information from the BioMart database
###################################################
Retrieves information from the BioMart database
genesymbols = getBM(attributes=c("refseq_mrna","entrezgene","hgnc_symbol"), 
filters="refseq_mrna",values=refseqids, mart=ensembl)


###################################################
### code chunk number 5: merge 
###################################################
Results <- merge(Rawdata, genesymbols, by.x = "refseq_mrna")
write.table(Results, file = "Results.txt", sep = "\t", 
col.names = FALSE, row.names = FALSE, quote = FALSE)