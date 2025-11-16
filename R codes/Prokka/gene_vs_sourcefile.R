library(data.table)
library(dplyr)
library(tidyr)

# Read in gff-master table
df <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/full_mastertable_gff.tsv", sep = "\t", select = c("source_file", "gene"))

# Delete every second row (since in column 'gene' counts are doubled)
new_df <- df[seq(1, nrow(df), by = 2), ]

# Harmonizing entries (e.g. ompA and ompA_1 to ompA)
new_df$gene <- sub("_.*", "", new_df$gene)

# Counts number of each variable
df_counts <- new_df %>%
  count(source_file, gene)  # creates a new column "n" automatically

# pivoting: variables become columns, counts are values
df_wide <- df_counts %>%
  pivot_wider(names_from = gene, values_from = n, values_fill = 0)

# Writing new table and save it
fwrite(df_wide, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_genes.tsv", sep = "\t", quote = FALSE)

# Creating new file with column names (with purpose to check which columns to eliminate later)
col_names <- names(df_wide)
gff_col_names <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/column_names_wide_genes.tsv"
write.table(x = col_names, file = gff_col_names, sep = "\t", row.names = FALSE, quote = FALSE)
