library(dplyr)

# Read in wide product table
product <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_product.tsv", sep = "\t", header = TRUE)


# [FOR PRODUCT FILTERED TABLE]
# Read in file with ID's to keep
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/filter_master_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
filtered_product <- product %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = filtered_product,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff_filter\\product_filtered.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)


# [FOR ALL C. SPP.]
# Read in file with ID's to keep - here I need only all sequences without species "Other"
keep_file <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/without_Other_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep <- unique(keep_file$ID_ND)

# Filter only matched ID's
filtered_product <- product %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = filtered_product,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\without_Other_product.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)

# [FOR C. SAKAZAKII]

# Read in file with ID to keep
keep_file_1 <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/sakazakii_metadata.tsv", sep = "\t", header = TRUE)

# Using column 'ID_ND' in the tsv-file
to_keep_1 <- unique(keep_file_1$ID_ND)

# Filter only matched ID's
sakazakii_product <- product %>%
  filter(source_file %in% to_keep_1)

# Write new tsv-file
write.table(
  x = sakazakii_product,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio gff\\sakazakii_product.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)
