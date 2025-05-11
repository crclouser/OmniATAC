#!/bin/bash
#SBATCH --job-name=atacseqNF
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=30G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yuh24003@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load nextflow/24.10.5

# Define output directory and create it
OUTDIR=../../results/nfcoreATACseq
mkdir -p ${OUTDIR}
cd ${OUTDIR}

# Define input files and genome
SAMPLESHEET=../../metadata/samplesheet.csv
GENOME=../../genome/GCF_000001405.26_GRCh38_genomic.fna
GFF=../../genome/GCF_000001405.26_GRCh38_genomic.gff  # Optional, if available

# Run nf-core/atacseq pipeline
nextflow run nf-core/atacseq -r 2.1.2 \
    --input ${SAMPLESHEET} \
    --fasta ${GENOME} \
    --gff ${GFF} \
    --read_length 75 \
    --outdir out \
    -resume \
    -profile xanadu \
    --singularity_pull_docker_container true \
    -with-trace trace.txt \
    -with-report report.html \
    -with-timeline timeline.html \
    -with-dag dag.png
