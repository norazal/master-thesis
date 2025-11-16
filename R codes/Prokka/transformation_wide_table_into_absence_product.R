library(data.table)

# Read in tsv-file 'wide_table' of column 'product'
dt <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_product.tsv", sep = "\t", header = TRUE)

# Identification of every column that contains any value (except for the first)
value_columns <- names(dt)[-1]

# Loop, that checks in every column if a value > 0 (keep 0), else transform into 1
for (col_name in value_columns) {
  dt[, (col_name) := ifelse(get(col_name) > 0, 1, 0)]
}

print(class(dt))

# Write a new table
fwrite(dt, "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_product_absence.tsv", sep = "\t")
