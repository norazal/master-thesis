library(dplyr)

# Read in wide table file
gene_orig <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_genes.tsv", sep = "\t", header = TRUE)
gene_absence <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_gene_absence.tsv", sep = "\t", header = TRUE)

# [1] All steps for wide_gene.tsv
# [wide gene table filtered]
# Using column 'ID_ND' in the tsv-file
keep_file <- fread("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\filter_master_metadata.tsv", sep = "\t", header = TRUE)
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
filtered_gene <- gene_orig %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = filtered_gene,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff_filter\\gene_filtered.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [wide gene table filtered - without species "Other"]
# Using column 'ID_ND' in the tsv-file
keep_file <- fread("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\Filtered Metadata\\without_Other_metadata.tsv", sep = "\t", header = TRUE)
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
filtered_gene <- gene_orig %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = filtered_gene,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff_filter\\without_Other_gene_filtered.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)

# [2] All steps for "wide_gene_absence.tsv"
# [wide gene absence table filtered]
# Using column 'ID_ND' in the tsv-file
keep_file <- fread("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\filter_master_metadata.tsv", sep = "\t", header = TRUE)
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
filtered_gene <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = filtered_gene,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff_filter\\gene_absence_filtered.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [ALL C. SPP. - without "Other"]
# Read in file with ID to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/without_Other_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
filtered_gene_absence <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = filtered_gene_absence,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\without_Other_gene_absence.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [C. SAKAZAKII]
# Read in file with ID to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/sakazakii_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
sakazakii_gene_absence <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = sakazakii_gene_absence,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\sakazakii_gene_absence.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [C. MALONATICUS]
# Read in file with ID to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/malonaticus_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
malonaticus_gene_absence <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = malonaticus_gene_absence,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\malonaticus_gene_absence.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [C. DUBLINENSIS]
# Read in file with ID to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/dublinensis_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
dublinensis_gene_absence <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = dublinensis_gene_absence,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\dublinensis_gene_absence.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [C. TURICENSIS]
# Read in file with ID to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/turicensis_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
turicensis_gene_absence <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = turicensis_gene_absence,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\turicensis_gene_absence.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [C. MUYTJENSII]
# Read in file with ID to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/muytjensii_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
muytjensii_gene_absence <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = muytjensii_gene_absence,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\muytjensii_gene_absence.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [C. UNIVERSALIS]
# Read in file with ID to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/universalis_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
universalis_gene_absence <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = universalis_gene_absence,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\universalis_gene_absence.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [C. CONDIMENTI]
# Read in file with ID to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/condimenti_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
condimenti_gene_absence <- gene_absence %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = condimenti_gene_absence,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\condimenti_gene_absence.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)