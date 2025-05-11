#!/bin/bash
#SBATCH --job-name=fasterq_dump_xanadu
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yuh24003@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err


# Set locale environment variables to avoid warnings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

hostname
date

#################################################################
# Download fastq files from SRA 
#################################################################

#export temporary files to this location
mkdir -p ../../TMPDIR
export TMPDIR=../../TMPDIR

# load software
module load parallel/20180122
module load sratoolkit/3.0.1

# The data are from this study:
    # https://www.ncbi.nlm.nih.gov/bioproject/PRJNA714409

# Output directory for fastq files
OUTDIR=../../data/fastq
    mkdir -p ${OUTDIR}

# Metadata file containing SRA accession numbers downloaded from the SRA's "Run Selector" page
METADATA=../../metadata/SraRunTable.txt 

# Accession list also downloaded from the SRA's "Run Selector" page
ACCLIST=../../metadata/SRR_Acc_List.txt

# use parallel to download 5 accessions at a time. 
echo "Downloading FASTQ files..."
cat $ACCLIST | parallel -j 5 "fasterq-dump -O ${OUTDIR} {}"

# compress the files
echo "Compressing FASTQ files..."
ls ${OUTDIR}/*fastq | parallel -j 10 gzip
