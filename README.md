# omniATAC workflow

Part 1 - Download Data
1. begin with creating and SRA table in the metadata directory
2. In the scripts directory access the 01_rawdata directory
3. Modify the file 01_downloadSRA.sh with the approriate links to database where files are located.
4. Also modify the 02_downloadGenome.sh file with the appropriate links to the database where your genome files are located.

Part 2 - Data QC
1. Run scripts in order 1-5
2. File 01_fastqc.sh will check the quality of the raw fastq files.
3. File 02_multiQC.sh will combine and summarize the fastqc data from step 1.
4. File 03_trimmomatic.sh will access the original fastq files and trim adpator sequences.
5. File 04_fastqc_trim.sh will rerun fastqc on the trimmed files to make sure adaptors have been removed.
6. File 05_multiqc_trim.sh will combine and summarize the trimmed fastqc data for all the samples.

Part 3 - Align Data
1. Run scripts 1-5 in order
2. File 01_index.sh will annotate the genome files downloaded in Part 1 in preparation for alignment
3. File 02_align.sh will align the trimmed fastq files to the annotated genome and create.bam and .bamai summary files for each sample. 
4. File 03_samtools_stats.sh will give a high level summary of the alignment stats
5. File 04_qualimap.sh will provide high level stats as to genomic features reads were mapped to.
5. File 05_multiqc.sh will summarize the qualimap data for all the samples in one document

Part 4 - ATACseq workflows that need to be worked out.
