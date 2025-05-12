# omniATAC workflow

Part 1 - Download Data
1. Begin by adding an SRA table (SraRunTable.txt)and accessionlist  to the metadata directory, an example is provided in the metadata directory. Downloaded from NCBI https://www.ncbi.nlm.nih.gov/bioproject/PRJNA######.
2. In the scripts directory access the 01_rawdata directory
3. Modify the file 01_downloadSRA.sh with the approriate links to database where files are located. Fastq files will be saved in the generated directory ../../data/fastq/
4. Also modify the 02_downloadGenome.sh file with the appropriate links to the database where your genome files are located. GFF and FASTA files will be saved in the generated directory ../../genome/

Part 2 - Data QC
1. Data QC will be done with the Nextflow nf_core/atacseq workflow. The workflow is described in this READ.ME file https://github.com/nf-core/atacseq/blob/master/README.md
2. A sample sheet will need to be created and stored in the 'metadata' directory, formatting for the sample sheet is described here https://nf-co.re/atacseq/usage#samplesheet-input, or sample loaded in 'metadata' directory can be used as reference.
3. Modify the script 01_ataseq_nf.sh in directory 02_nfcore_atac with appropriate location of gff and fasta files. At the bottom of the .sh file adjust with appropriate read length for your sample. You may want to update to the latest version of the atacseq workflow as well (currently v2.1.2).
4. When 01_ataseq_nf.sh is completely modified to fit your needs launch on Xanadu server with sbatch command.
5. A 'results' directory will be generated in the OmniATAC folder as well as a subdirectory 'nfcoreATACseq' that will contain all data generated for this project. More information on the files generated can be found here https://nf-co.re/atacseq/output. 
6. If the pipeline should fail check the logfiles or report.html to identify problem. Once corrected modify 02_nfcore_atac.sh file with the -resume to pick up where the analysis left off.  Be sure to delete report.html, timeline.html and trace.txt files from prior attempt to resume analysis.

Part 3 - Continue with Secondary Analysis pipelines of choice in R to better visualize data.

