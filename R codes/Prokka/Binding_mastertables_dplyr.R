library(dplyr)
library(readr)

# Setting working directory
setwd("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/")

# Defining tsv-files to read in
master_tables <- c(
  "master_table_gff(1).tsv",
  "master_table_gff(2).tsv",
  "master_table_gff(3).tsv",
  "master_table_gff(4).tsv",
  "master_table_gff(5).tsv"
)

# Creating new empty list to save data frames
list_df <- list()

# Loop through every file
for (file_path in master_tables) {
  # Reading tsv-file with read_tsv from readr package
  data_files <- readr::read_tsv(file_path, col_types = cols(.default = col_character()))
  # Adding content to list 'list_df'
  list_df[[file_path]] <- data_files
}

# Combination of data frames with function bind_rows()
combined_data <- bind_rows(list_df)

# Check first rows and column names
print(head(combined_data))
print(names(combined_data))

# Writing a new tsv-file with content of 'master_tables'
readr::write_tsv(combined_data, "full_mastertable_gff.tsv")