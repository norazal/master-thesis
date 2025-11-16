# [1] Preparation of packages
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
if (!requireNamespace("rtracklayer", quietly = TRUE)) {
  BiocManager::install("rtracklayer")
}
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

# [1.1] Libraries
library(rtracklayer)
library(dplyr)

# [2.1] Definition of file path

gff_directory <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/gff_prokka/p2"

process_gff_files <- list.files(
  path = gff_directory,
  pattern = "\\.gff$|\\.gff3$",
  full.names = TRUE,
  recursive = FALSE
)

# [2] Function to take a path, where all GFF-files are found, reading every file
#     and attaches its content to a data frame. Every data frame gets a column
#     added, with its file name, where content is taken from.

read_and_append_gff_files <- function(gff_file_paths) {
  # Creating an empty data frame for combined data
  list_of_dfs <- list()
  
  # Loop through every directory
  for (i in seq_along(gff_file_paths)) {
    file_path <- gff_file_paths[i]
    # Extract name of file without path or extension
    file_name <- tools::file_path_sans_ext(basename(file_path))
    
    # Reading gff-file - import() from library 'rtracklayer' provides a GRanges-object
    gff_granges <- import(file_path, format = "gff3")
    
    # Converts GRanges-object into a data frame
    gff_df <- as.data.frame(gff_granges)
    
    # [2.1] Convert lists to strings (command write.table() is not applicable on lists)
    # Identification of 'list' columns
    list_columns <- sapply(gff_df, is.list)
    
    # Convert every 'list' column into string
    if (any(list_columns)) {
      for (col_name in names(gff_df)[list_columns]) {
        gff_df[[col_name]] <- sapply(gff_df[[col_name]], function(x) {
          if (is.null(x) || length(x) == 0) {
            return(NA_character_) # empty lists or NULL as NA
          } else {
            return(paste(x, collapse = ";"))
          }
        })
      }
    }
    
    # Attaching file name as new column
    gff_df$source_file <- file_name
    
    # Adding data frame to list
    list_of_dfs[[i]] <- gff_df

  }
  # Attaching all data frames
  all_gff_data <- bind_rows(list_of_dfs)
  
  return(all_gff_data)
}

start_time <- Sys.time()
# Enacting function
combined_gff_df <- read_and_append_gff_files(process_gff_files)

#print(head(combined_gff_df))
#print(str(combined_gff_df))

#sapply(combined_gff_df, class)

tsv_output_file <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/master_table_gff(2).tsv"

write.table(
  x = combined_gff_df,
  file = tsv_output_file,
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)

end_time <- Sys.time()
time_taken <- end_time - start_time

cat("Data frame was saved successfully as tsv-file in:", tsv_output_file, "\n")
cat("Duration of operation:", format(time_taken, units = "auto"), "\n\n")