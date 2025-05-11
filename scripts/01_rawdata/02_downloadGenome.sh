#!/bin/bash
#SBATCH --job-name=get_genome
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --mem=2G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yuh24003@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

echo `hostname`
date

#################################################################
# Download genome and annotation from ENSEMBL
#################################################################

# load software
module load samtools/1.16.1

# output directory
GENOMEDIR=../../genome
mkdir -p $GENOMEDIR

# we're using the human reference GRCh38
    # we'll download the genome, GTF annotation and transcript fasta
    # https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.26_GRCh38/

# download the genome
wget -P ${GENOMEDIR} https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.26_GRCh38/GCF_000001405.26_GRCh38_genomic.fna.gz

# download the GFF annotation
wget -P ${GENOMEDIR} https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.26_GRCh38/GCF_000001405.26_GRCh38_genomic.gff.gz

# download the transcript fasta, should I decide to do RNAseq analysis
wget -P ${GENOMEDIR} https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.26_GRCh38/GCF_000001405.26_GRCh38_rna.fna.gz

# decompress files
gunzip ${GENOMEDIR}/*gz

# generate simple samtools fai indexes 
samtools faidx ${GENOMEDIR}/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna_sm.toplevel.fa
samtools faidx ${GENOMEDIR}/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.cdna.all.fa
