install.packages("data.table")
install.packages("tidyverse")

library(data.table)

# FIRST STEP: Analyzing the format of date
# [1] Import data into RStudio
 meta_data <- fread("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\Crono(merged)_2025_02_03.csv")
 head(meta_data)

 
# SECOND STEP: Mutation of column 'Year'
# [2.1] Mutating column 'Year' - display of different entries

# Replace empty entries with 'NA'
 meta_data$Year[meta_data$Year == ""] <- NA

# [Optional 1] Show number of entries to analyze format and data of column 'Year'
# nr_entries <- table(meta_data$Year, useNA = "ifany")

# [Optional 1] Making of new text-file and print information into new text-file
# output_file_1 <- "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\Number_date.txt"
# write.table(nr_entries, file = output_file_1, sep = "\t", quote = FALSE)


# [2.2] After knowing the format and frequencies of entries (format: YYYY-MM-DD) formatting column into date format
# Checking current format
 str(meta_data$Year)

# Mutate entries in column 'Year'
# Replacement of uncommon descriptions
meta_data$Year[meta_data$Year == "1900/1953"] <- "1953"
meta_data$Year[meta_data$Year == "1900/1954"] <- "1954"

# Make a uniform column: if only year is given, attach "-01-01", if only year and month is given, attach "-01", everything that has more info
# cut into a maximum of 10 characters (format: YYYY-MM-DD)

meta_data$Year <- ifelse(
  nchar(meta_data$Year) == 4,
  paste0(meta_data$Year, "-01-01"),
  ifelse(nchar(meta_data$Year) == 7,
         paste0(meta_data$Year, "-01"),
         substr(meta_data$Year, 1, 10)
  )
)

# Set column into format of date - sets all entries, that are not in given format into 'NA'
meta_data$Year <- as.Date(meta_data$Year, format = "%Y-%m-%d")

# Change format date into integer (only keeping years as integer)
meta_data$Year <- as.integer(format(meta_data$Year, "%Y"))

# [Optional 2] Checking the unique entries after manipulating them
# nr_date_entries <- table(meta_data$Year, useNA = "ifany")

# [Optional 2] Creation of new text-file and print information into new text-file
# output_file <- "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\Number_date_after.txt"
# write.table(nr_date_entries, file = output_file, sep = "\t", quote = FALSE)


# THIRD STEP: Manipulation of column 'Species'
# [3.1] Unifying entries in column 'Species'

meta_data$Species[grep("C\\. sakazakii|Cronobacter sakazakii", meta_data$Species, ignore.case = TRUE)] <- "Cronobacter sakazakii"
meta_data$Species[grep("C\\. malonaticus|Cronobacter malonaticus", meta_data$Species, ignore.case = TRUE)] <- "Cronobacter malonaticus"
meta_data$Species[grep("C\\. turicensis|Cronobacter turicensis", meta_data$Species, ignore.case = TRUE)] <- "Cronobacter turicensis"
meta_data$Species[grep("C\\. universalis|Cronobacter universalis", meta_data$Species, ignore.case = TRUE)] <- "Cronobacter universalis"
meta_data$Species[grep("C\\. condimenti|Cronobacter condimenti", meta_data$Species, ignore.case = TRUE)] <- "Cronobacter condimenti"
meta_data$Species[grep("C\\. dublinensis|Cronobacter dublinensis", meta_data$Species, ignore.case = TRUE)] <- "Cronobacter dublinensis"
meta_data$Species[grep("C\\. muytjensii|Cronobacter muytjensii", meta_data$Species, ignore.case = TRUE)] <- "Cronobacter muytjensii"
meta_data$Species[grep("others|other|Cronobacter sp\\.", meta_data$Species, ignore.case = TRUE)] <- "Other"

# [Optional 3] Checking the unique entries after manipulating them
# nr_species_entries <- table(meta_data$Species, useNA = "ifany")
# print(nr_species_entries)


# FOURTH STEP: Manipulation of column 'Source' into 'Source_harmonized'

library(tidyverse)

# Reading csv-files with columns 'Source' and 'Source_harmonized'
source_map <- fread("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\Sources_rename.csv")

# Creating a temporary new column, comparing entries of column 'Source' and writes new entry into temporary column 'Source'
# After that writing entries of temporary column into new column 'Sources_harmonized'
meta_data_2 <- meta_data %>%
  left_join(source_map, by = c("Source" = "Source")) %>%
  mutate(Source_harmonized = coalesce(New_Group, Source)) %>%
  # Deletion of temporary column
  select(-New_Group)

# Replace empty entries with 'NA'
meta_data_2$Source_harmonized[meta_data_2$Source_harmonized == ""] <- "Unknown and Unclassified Sources"


# FIFTH STEP: Manipulation of columns 'Country', 'Continent' and 'Region'

# [Optional 5] Show number of entries to analyze format and data
# nr_entries_5 <- table(meta_data_2$Country, useNA = "ifany")

# [Optional 5] Making of new text-file and print information into new text-file
# output_file_5 <- "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\Number_country.txt"
# write.table(nr_entries_5, file = output_file_5, sep = "\t", quote = FALSE)

library(tidyverse)

#meta_data_2$Region = as.character(meta_data_2$Region)

# Replacing not specific entries and empty strings with 'NA'
meta_data <- meta_data_2 %>%
  mutate(
    Country = na_if(Country, "missing"),
    Country = na_if(Country, "Not Provided"),
    Country = na_if(Country, "not provided"),
    Country = na_if(Country, "Not applicable"),
    Country = na_if(Country, "not collected"),
    Country = na_if(Country, "unknown"),
    Country = na_if(Country, "Unknown"),
    Country = na_if(Country, "")
  ) %>%

  mutate(
    # Creation of temporary column for 'Country'
    # stringr::str_extract extracts part after ':'
    extracted_region = str_extract(Country, "(?<=:).*"),
    
    # Filling of column 'Region' with those parts
    Region = if_else(is.na(Region), extracted_region, Region),
    
    # Leaving parts before ':'
    # stringr::str_remove removes everything after ':'
    Country = str_remove(Country, ":.*")
  ) %>%
  
  mutate(
    # Rename of 'UK' into 'United Kingdom'
    Country = if_else(Country == "UK", "United Kingdom", Country)
  ) %>%
  
  # Deletion of temporary column
  select(-extracted_region)

# SIXTH STEP: Filter in ascending order and saving table as csv-file and tsv-file

final_meta <- meta_data %>%
  arrange(ID_ND)

# Replace empty entries with "Unknown"
adapted <- final_meta %>%
  mutate(
    Country = if_else(Country == "", "Unknown", Country),
    Source_harmonized = if_else(Source_harmonized == "", "Unknown and Unclassified Sources", Source_harmonized)
  )

write.csv(adapted, "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\master_metadata.csv", row.names = FALSE, na = "", fileEncoding = "UTF-8")

write.table(
  x = adapted,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\master_metadata.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)
