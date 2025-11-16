# master-thesis
Codes (bash and R) from my master thesis "Comparative genomic analysis of the bacterial genus Cronobacter"

# Code logbook:
Metadata gathering:

From NCBI (using Linux’ terminal):
Creating a conda environment:
conda create -n ncbi_datasets
Installation of NCBI datasets (datasets version 15.16.1):
conda install -c conda-forge ncbi-datasets-cli
Activation of conda environment for datasets:
conda activate ncbi_datasets
Command for gathering metadata table of genomes from NCBI:
datasets summary genome taxon cronobacter --assembly-source all --as-json-lines ¬| dataformat tsv genome > NCBI_cronobacter_2025.txt
Retrieving original table as txt-file and transforming it into an MS Excel-file:
•	MS Excel-file “NCBI_original_2025-02-03.xlsx” on February 3rd, 2025
From PubMLST (Website: https://pubmlst.org/bigsdb?db=pubmlst_cronobacter_isolates):
•	MS Excel-file “PubMLST_original_2025_02_03.xlsx” on February 3rd, 2025
Adaptation of NCBI metadata:
•	Multiple lines are visible because of different entries in the columns. First, unnecessary columns need to be eliminated. For that, certain columns need to be kept, e.g. Assembly Accession, Assembly Name, Organism Name. Further columns need to be extracted. For that, these columns are isolated into a single excel sheet, where columns of Assembly Accession and columns of Assembly BioSample Attribute Name and Assembly BioSample Attribute Value are transported. There these columns need to be pivoted (in MS Excel), so that lines of columns “Assembly BioSample Attribute Name” become new columns and beneath the lines with Assembly Accession and Assembly BioSample Attribute Value. Caution, that no counting will be performed, instead data should not be manipulated.
After pivoting these new columns are attached to the original file. There are columns of “strain”, “isolation_source”, “collection_date” and “geo_loc_name” that should be kept.
Since meta data from NCBI are available from two databases (RefSeq and GenBank), entries of RefSeq are preferred. For that, in excel eliminating duplicate lines with PowerQuery, where the first line will be kept and the further ones will be deleted. So, sorting entries from lowest to highest character needs to be done. After eliminating duplicates, the right information should be available.
Merging of both metadata:
•	This step is described in Chapter 3.1: retrieving MS Excel-file “Crono(merged)_2025_02_03.xlsx” on March 4th, 2025
Download of genomes:
•	Bash-script “vsc_dl_ncbi.sh” on March 5th, 2025 using table “NCBI_download_2025_02_03.csv”
•	Bash-script “vsc_dl_pubmlst.sh” on June 4th, 2024 using table “PubMLST_download_20240327.csv”
•	Download of rest of genomes that are listed in the PubMLST metadata table via PubMLST manually, renaming them as in metadata table and moving them into directory with all other genomes
•	Divide all genomes into five different directories to ensure parallelization of programs (“p1”, “p2”, “p3”, “p4” and “p5”)
CheckM2:
Installation of CheckM2 environment:
conda create --prefix=/gpfs/data/fs71579/diepn/checkm2_env -c bioconda -c conda-forge checkm2
Apply CheckM2 on downloaded genomes as FASTA-files:
•	Bash-scripts “checkm2_p1.sh”, “checkm2_p2.sh”, “checkm2_p3.sh”, “checkm2_p4.sh”, “checkm2_p5.sh” on April 16th, 2025
Merging and analyzing CheckM2 reports:
•	R-code “Quality report_merged.R” on May 1st, 2025
Excluding filtered genomes that did not meet the quality thresholds (also in metadata table):
•	Bash-script “mv_excluded.sh” on May 11th, 2025
•	R-code “Filter_master_metadata.R” on May 11th, 2025 – excluding part with “gff_quality_filtered.tsv” since it did not exist at that time
Prokka:
Installation of Prokka environment:
conda create --prefix /gpfs/data/fs71579/diepn/prokka_env
Installation of Prokka:
conda install --prefix /gpfs/data/fs71579/diepn/prokka_env -c conda-forge -c bioconda -c defaults prokka
Applying Prokka on remaining genomes:
•	Bash-scripts “prokka_p1.sh”, “prokka_p2.sh”, “prokka_p3.sh”, “prokka_p4.sh” and “prokka_p5.sh” on May 12th, 2025
Copy out all GFF-files and then download them from VSC4:
•	Bash-script “cp_gff-files.sh” on May 29th, 2025
Creation of master table from Prokka’s GFF-files:
•	R-codes “GFF_files_to_mastertable_p1.R”, “GFF_files_to_mastertable_p2.R”, “GFF_files_to_mastertable_p3.R”, “GFF_files_to_mastertable_p4.R”, “GFF_files_to_mastertable_p5.R” on June 3rd, 2025
Merging all parts:
•	R-code “Binding_mastertables_dplyr.R” on June 3rd, 2025
Using the columns “source_file”, “gene” and “product” – transforming them into wide tables:
•	R-code “product_vs_sourcefile.R” on June 10th, 2025
•	R-code “gene_vs_sourcefile.R” on July 17th, 2025
Creation of wide absence/presence tables for products and genes:
•	R-Code “transformation_wide_table_into_absence_product.R” on June 12th, 2025
•	R-Code “transformation_wide_table_into_absence_gene.R” on July 18th, 2025
Quality check of GFF-files using wide table product absence:
•	R-Code “GFF_quality_filter.R” on August 18th, 2025
Filtering of master metadata table (after quality checks via CheckM2 and Prokka):
•	R-Code “Filter_master_metadata.R” including part with “gff_quality_filtered.tsv” on August 19th, 2025
Gathering the master metadata table – creating filtered metadata table for each species:
•	R-Code “Filter_Species_metadata.R” on August 19th, 2025
Filtering of wide tables and absence/presence tables for products and genes:
•	R-Code “widetable_gene_absence_filtered.R” on August 19th, 2025
•	R-Code “widetable_product_absence_filtered.R” on August 19th, 2025
Harmonizing metadata:
Harmonizing data in the metadata table retrieving the master metadata table:
•	R-code “Merged_to_master_metadata.R” on August 19th, 2025
•	R-code “Merged_to_master_metadata_2.R” on August 19th, 2025
Analysis of core and accessory genomes:
Creating tables for core-, softcore-, shell- and cloud-genomes of each species:
•	R-code “core_accessory_genomes.R” on August 19th, 2025
Principal Coordinates Analysis:
Applying Bray-Curtis dissimilarity and PCoA on IRIS dataset:
•	R-code “iris_pcoa.R” on July 27th, 2025
Applying Bray-Curtis dissimilarity and PCoA on “gene_filtered.tsv” and “product_filtered.tsv”:
•	R-code “Cr_spp_bc_gene_pcoa.R” on August 20th, 2025
•	R-code “Cr_spp_bc_product_pcoa.R” on August 20th, 2025
Applying Jaccard index and PCoA on “gene_filtered.tsv” and “product_filtered.tsv”:
•	R-code “Cr_spp_jac_gene_absence_pcoa.R” on August 20th, 2025
•	R-code “Cr_spp_jac_product_absence_pcoa.R” on August 20th, 2025
Cluster Analysis:
Conduct PERMANOVA on Bray-Curtis dissimilarity matrix and plot results, after clustering all genomes belonging to Cronobacter spp.:
•	R-code “Genes_PERMANOVA_crspp.R” on November 9th, 2025
Conduct PERMANOVA on Bray-Curtis dissimilarity matrix and plot results, after clustering all genomes belonging to Cronobacter spp. with exception of C. sakazakii:
•	R-code “Genes_PERMANOVA_wo_sakazakii.R” on November 10th, 2025
Plotting results:
•	R-code “Plot_genes_absolute_freq.R” on October 30th, 2025
•	R-code “Plot_genes_relative_freq.R” on October 30th, 2025
•	R-code “Plot_metadata_continent.R” on October 30th, 2025
•	R-code “Plot_metadata_source.R” on October 30th, 2025
•	R-code “Plot_metadata_year.R” on October 30th, 2025
•	R-code “Plot_metadata_database_species.R” on October 30th, 2025
•	R-code “Plot_metadata_database_species_back_to_back.R” on October 30th, 2025
