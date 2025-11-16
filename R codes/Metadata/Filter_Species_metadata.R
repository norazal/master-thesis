library(dplyr)

# Read in filtered master metadata table file
frame <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/filter_master_metadata.tsv", sep = "\t", header = TRUE)


# [Cronobacter spp.]
# Filter out species "Other", so that only Cronobacter spp. remain
filtered <- frame %>%
  filter(Species != "Other")

# Write new tsv-file for later purpose
path_file <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/without_Other_metadata.tsv"
write.table(filtered, file = path_file, sep = "\t", row.names = FALSE, quote = FALSE)


# [Cronobacter sakazakii]
# Filter out species "C. sakazakii"
sakazakii <- frame %>%
  filter(Species == "Cronobacter sakazakii")

# Write new tsv-file with only Cronobacter sakazakii
path_sak <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/sakazakii_metadata.tsv"
write.table(sakazakii, file = path_sak, sep = "\t", row.names = FALSE, quote = FALSE)


# [Cronobacter malonaticus]
# Filter out species "C. malonaticus"
malonaticus <- frame %>%
  filter(Species == "Cronobacter malonaticus")

# Write new tsv-file with only Cronobacter malonaticus
path_mal <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/malonaticus_metadata.tsv"
write.table(malonaticus, file = path_mal, sep = "\t", row.names = FALSE, quote = FALSE)


# [Cronobacter dublinensis]
# Filter out species "C. dublinensis"
dublinensis <- frame %>%
  filter(Species == "Cronobacter dublinensis")

# Write new tsv-file with only Cronobacter dublinensis
path_dub <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/dublinensis_metadata.tsv"
write.table(dublinensis, file = path_dub, sep = "\t", row.names = FALSE, quote = FALSE)


# [Cronobacter turicensis]
# Filter out species "C. turicensis"
turicensis <- frame %>%
  filter(Species == "Cronobacter turicensis")

# Write new tsv-file with only Cronobacter turicensis
path_tur <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/turicensis_metadata.tsv"
write.table(turicensis, file = path_tur, sep = "\t", row.names = FALSE, quote = FALSE)


# [Cronobacter muytjensii]
# Filter out species "C. muytjensii"
muytjensii <- frame %>%
  filter(Species == "Cronobacter muytjensii")

# Write new tsv-file with only Cronobacter muytjensii
path_muy <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/muytjensii_metadata.tsv"
write.table(muytjensii, file = path_muy, sep = "\t", row.names = FALSE, quote = FALSE)


# [Cronobacter universalis]
# Filter out species "C. universalis"
universalis <- frame %>%
  filter(Species == "Cronobacter universalis")

# Write new tsv-file with only Cronobacter universalis
path_uni <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/universalis_metadata.tsv"
write.table(universalis, file = path_uni, sep = "\t", row.names = FALSE, quote = FALSE)


# [Cronobacter condimenti]
# Filter out species "C. condimenti"
condimenti <- frame %>%
  filter(Species == "Cronobacter condimenti")

# Write new tsv-file with only Cronobacter condimenti
path_con <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/condimenti_metadata.tsv"
write.table(condimenti, file = path_con, sep = "\t", row.names = FALSE, quote = FALSE)


# [Other]
# Filter out species "Other
other <- frame %>%
  filter(Species == "Other")

# Write new tsv-file with only Other
path_other <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/other_metadata.tsv"
write.table(other, file = path_other, sep = "\t", row.names = FALSE, quote = FALSE)