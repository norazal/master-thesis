library(dplyr)
library(data.table)

# [1] Import data into RStudio
meta_data1 <- fread("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\master_metadata.tsv", header = TRUE, sep = "\t")

# [2] Adding missing continents
# [Optional 1] Show number of entries to analyze format and data
#nr_entries_1 <- table(meta_data1$Country, useNA = "ifany")

# [Optional 1] Making of new text-file and print information into new text-file
#output_file_1 <- "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\Number_country_1.txt"
#write.table(nr_entries_1, file = output_file_1, sep = "\t", quote = FALSE)

# Creating a lookup-table: Country -> Continent
country_continent <- data.table(
  Country = c(
    "Argentina","Australia","Austria","Belgium","Brazil","Canada","Chile","China",
    "Czech Republic","Denmark","Dominican Republic","France","Germany","Iceland",
    "India","Ireland","Israel","Italy","Japan","Jordan","Kenya","Lebanon",
    "Malaysia","Mexico","Netherlands","New Zealand","Norway","Pakistan","Poland",
    "Portugal","Saudi Arabia","Singapore","Slovakia","Slovenia","South Africa",
    "South Korea","Swaziland","Switzerland","Taiwan","Thailand","The Netherlands",
    "Turkey","United Kingdom","USA","Zimbabwe"
  ),
  Continent_Lookup = c(
    "South America","Oceania","Europe","Europe","South America","North America",
    "South America","Asia","Europe","Europe","North America","Europe","Europe",
    "Europe","Asia","Europe","Asia","Europe","Asia","Asia","Africa","Asia","Asia",
    "North America","Europe","Oceania","Europe","Asia","Europe","Europe","Asia",
    "Asia","Europe","Europe","Africa","Asia","Africa","Europe","Asia","Asia",
    "Europe","Asia","Europe","North America","Africa"
  )
)

# Join of tables
meta_data1[country_continent, on = .(Country), Continent_Lookup := i.Continent_Lookup]

# Replace of empty cells
meta_data1[, Continent := fifelse(is.na(Continent) | Continent == "", Continent_Lookup, Continent)]

# Deletion of support column
meta_data1[, Continent_Lookup := NULL]


# [3] Replacing all "NA"-entries with "Unknown" or "Unknown and Unclassified Sources"
# Rewrite empty strings as "NA"
meta_data1[meta_data1 == ""] <- NA

# Replace all NA-values in the columns "Year", "Country", "Continent", "Source_harmonized"
meta_data1 <- meta_data1 %>%
  mutate(
    across(c(Year, Country, Continent), ~coalesce(as.character(.), "Unknown")),
    Source_harmonized = coalesce(as.character(Source_harmonized), "Unknown and Unclassified Sources")
  )

# [4] Write new table
write.table(
  meta_data1,
  file = "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\master_metadata_final.tsv", 
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
  )

write.csv(meta_data1, "C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio tables\\master_metadata_final.csv", row.names = FALSE, na = "", fileEncoding = "UTF-8")