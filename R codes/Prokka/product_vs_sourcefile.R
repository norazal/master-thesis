library(data.table)
library(dplyr)
library(tidyr)

# Read GFF-master table
df <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/full_mastertable_gff.tsv", sep = "\t", select = c("source_file", "product"))

# Count how often each variable appears for each ID
df_counts <- df %>%
  count(source_file, product)  # creates column "n" automatically

# Pivoting: each variable turns to a column - counts are values
df_wide <- df_counts %>%
  pivot_wider(names_from = product, values_from = n, values_fill = 0)

# Writing new file
fwrite(df_wide, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_product.tsv", sep = "\t", quote = FALSE)


