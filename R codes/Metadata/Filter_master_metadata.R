library(dplyr)

# Reading master meta data table
master_table <- read.csv("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\master_metadata_final.csv")

# Reading 'included sequences'-tsv-file
tsv_data <- read.delim("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio quality reports\\Included\\included_data.tsv", header = TRUE, sep = "\t")

# Using column 'Name' in the tsv-file
to_keep <- unique(tsv_data$Name)

# Filter only matched ID's and Names
filtered_master_table <- master_table %>%
  filter(ID_ND %in% to_keep)

# Reading 'gff filtered' file
tsv_data1 <- read.delim("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff_filter/gff_quality_filtered.tsv", header = TRUE, sep ="\t")

# Using column 'source_file' in the tsv-file
to_keep1 <- unique(tsv_data1$source_file)

# Filter only matched source_file's and ID_ND
filtered_master_table1 <- filtered_master_table %>%
  filter(ID_ND %in% to_keep1)

# Writing csv- and tsv-file
write.csv(filtered_master_table1, "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\filter_master_metadata.csv", row.names = FALSE, na = "", fileEncoding = "UTF-8")

write.table(
  x = filtered_master_table1,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\filter_master_metadata.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)
