# [1] Import of .tsv-files, merging and sorting them in ascending order by "Name"
file_list <- list.files(path = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio quality reports", pattern = "\\.tsv$", full.names = TRUE)
data_list <- lapply(file_list, function(x) read.table(x, sep = "\t", header = TRUE))
merged_data <- do.call(rbind, data_list)
sorted_data <- merged_data[order(merged_data$Name), ]

write.table(sorted_data, "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio quality reports\\full_quality_report.tsv", sep = "\t", row.names = FALSE, quote = FALSE)

# [2] Filter out rows with completeness under 90.0 and contamination above 5.0
filtered <- subset(sorted_data, Completeness >= 90.0 & Contamination <= 5.0)
excluded_filter <- sorted_data[!(row.names(sorted_data) %in% row.names(filtered)), ]

# [2.1] Write a table of excluded rows
write.table(excluded_filter, "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio quality reports\\Excluded\\excluded_filtered.tsv", sep = "\t", row.names = FALSE, quote = FALSE)

# [3] Remove duplicates ignoring column 'Name'
cols_to_check <- setdiff(names(filtered), "Name")
is_duplicate <- duplicated(filtered[, cols_to_check])

# [3.1] Included = rows passing filter and not duplicated
included <- filtered[!is_duplicate, ]

# [3.2] Excluded = rows that were duplicates
excluded_duplicates <- filtered[is_duplicate, ]

# [4] Write table with included rows and another table with excluded duplicated rows
write.table(included, "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio quality reports\\Included\\included_data.tsv", sep = "\t", row.names = FALSE, quote = FALSE)
write.table(excluded_duplicates, "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio quality reports\\Excluded\\excluded_duplicates.tsv", sep = "\t", row.names = FALSE, quote = FALSE)

