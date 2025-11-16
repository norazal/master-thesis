# [ALL C. SPP.]
# Read in filtered gene absence table file
data_read <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/without_Other_gene_absence.tsv", sep = "\t", header = TRUE)
filtered_gene_absence <- as.data.frame(data_read)

# Calculation of column sum (without first column "source_file")
col_sum <- colSums(filtered_gene_absence[ , -1])
nr_crspp <- nrow(filtered_gene_absence)

# Filter columns with column sum above 99.9% and below (core and accessory) - Number of samples = 3910
col_core <- names(col_sum[col_sum >= 0.999 * nr_crspp])
col_softcore <- names(col_sum[col_sum < 0.999 * nr_crspp & col_sum >= 0.95 * nr_crspp])
col_shell <- names(col_sum[col_sum < 0.95 * nr_crspp & col_sum > 0.10 * nr_crspp])
col_cloud <- names(col_sum[col_sum < 0.1 * nr_crspp & col_sum > 0])

# New data frames with selected columns
df_core <- filtered_gene_absence[ , c("source_file", col_core)]
df_softcore <- filtered_gene_absence[ , c("source_file", col_softcore)]
df_shell <- filtered_gene_absence[ , c("source_file", col_shell)]
df_cloud <- filtered_gene_absence[ , c("source_file", col_cloud)]

# Write new tables with core and accessory genomes
write.table(df_core, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_spp_core_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_softcore, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_spp_softcore_genome.tsv",  sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_shell, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_spp_shell_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_cloud, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_spp_cloud_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


# [C. SAKAZAKII]
# Read in filtered gene absence table file
data_read <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/sakazakii_gene_absence.tsv", sep = "\t", header = TRUE)
filtered_gene_absence <- as.data.frame(data_read)

# Calculation of column sum (without first column "source_file")
col_sum <- colSums(filtered_gene_absence[ , -1])
nr_crsak <- nrow(filtered_gene_absence)

# Filter columns with column sum above 99.9% and below (core and accessory) - Number of samples = 3053
col_core <- names(col_sum[col_sum >= 0.999 * nr_crsak])
col_softcore <- names(col_sum[col_sum < 0.999 * nr_crsak & col_sum >= 0.95 * nr_crsak])
col_shell <- names(col_sum[col_sum < 0.95 * nr_crsak & col_sum > 0.10 * nr_crsak])
col_cloud <- names(col_sum[col_sum < 0.1 * nr_crsak & col_sum > 0])

# New data frames with selected columns
df_core <- filtered_gene_absence[ , c("source_file", col_core)]
df_softcore <- filtered_gene_absence[ , c("source_file", col_softcore)]
df_shell <- filtered_gene_absence[ , c("source_file", col_shell)]
df_cloud <- filtered_gene_absence[ , c("source_file", col_cloud)]

# Write new tables with core and accessory genomes
write.table(df_core, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_sakazakii_core_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_softcore, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_sakazakii_softcore_genome.tsv",  sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_shell, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_sakazakii_shell_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_cloud, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_sakazakii_cloud_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


# [C. MALONATICUS]
# Read in filtered gene absence table file
data_read <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/malonaticus_gene_absence.tsv", sep = "\t", header = TRUE)
filtered_gene_absence <- as.data.frame(data_read)

# Calculation of column sum (without first column "source_file")
col_sum <- colSums(filtered_gene_absence[ , -1])
nr_mal <- nrow(filtered_gene_absence)

# Filter columns with column sum above 99.9% and below (core and accessory) - Number of samples = 299
col_core <- names(col_sum[col_sum >= 0.999 * nr_mal])
col_softcore <- names(col_sum[col_sum < 0.999 * nr_mal & col_sum >= 0.95 * nr_mal])
col_shell <- names(col_sum[col_sum < 0.95 * nr_mal & col_sum > 0.10 * nr_mal])
col_cloud <- names(col_sum[col_sum < 0.1 * nr_mal & col_sum > 0])

# New data frames with selected columns
df_core <- filtered_gene_absence[ , c("source_file", col_core)]
df_softcore <- filtered_gene_absence[ , c("source_file", col_softcore)]
df_shell <- filtered_gene_absence[ , c("source_file", col_shell)]
df_cloud <- filtered_gene_absence[ , c("source_file", col_cloud)]

# Write new tables with core and accessory genomes
write.table(df_core, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_malonaticus_core_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_softcore, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_malonaticus_softcore_genome.tsv",  sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_shell, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_malonaticus_shell_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_cloud, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_malonaticus_cloud_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


# [C. DUBLINENSIS]
# Read in filtered gene absence table file
data_read <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/dublinensis_gene_absence.tsv", sep = "\t", header = TRUE)
filtered_gene_absence <- as.data.frame(data_read)

# Calculation of column sum (without first column "source_file")
col_sum <- colSums(filtered_gene_absence[ , -1])
nr_dub <- nrow(filtered_gene_absence)

# Filter columns with column sum above 99.9% and below (core and accessory) - Number of samples = 264
col_core <- names(col_sum[col_sum >= 0.999 * nr_dub])
col_softcore <- names(col_sum[col_sum < 0.999 * nr_dub & col_sum >= 0.95 * nr_dub])
col_shell <- names(col_sum[col_sum < 0.95 * nr_dub & col_sum > 0.10 * nr_dub])
col_cloud <- names(col_sum[col_sum < 0.1 * nr_dub & col_sum > 0])

# New data frames with selected columns
df_core <- filtered_gene_absence[ , c("source_file", col_core)]
df_softcore <- filtered_gene_absence[ , c("source_file", col_softcore)]
df_shell <- filtered_gene_absence[ , c("source_file", col_shell)]
df_cloud <- filtered_gene_absence[ , c("source_file", col_cloud)]

# Write new tables with core and accessory genomes
write.table(df_core, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_dublinensis_core_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_softcore, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_dublinensis_softcore_genome.tsv",  sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_shell, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_dublinensis_shell_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_cloud, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_dublinensis_cloud_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


# [C. TURICENSIS]
# Read in filtered gene absence table file
data_read <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/turicensis_gene_absence.tsv", sep = "\t", header = TRUE)
filtered_gene_absence <- as.data.frame(data_read)

# Calculation of column sum (without first column "source_file")
col_sum <- colSums(filtered_gene_absence[ , -1])
nr_tur <- nrow(filtered_gene_absence)

# Filter columns with column sum above 99.9% and below (core and accessory) - Number of samples = 222
col_core <- names(col_sum[col_sum >= 0.999 * nr_tur])
col_softcore <- names(col_sum[col_sum < 0.999 * nr_tur & col_sum >= 0.95 * nr_tur])
col_shell <- names(col_sum[col_sum < 0.95 * nr_tur & col_sum > 0.10 * nr_tur])
col_cloud <- names(col_sum[col_sum < 0.1 * nr_tur & col_sum > 0])

# New data frames with selected columns
df_core <- filtered_gene_absence[ , c("source_file", col_core)]
df_softcore <- filtered_gene_absence[ , c("source_file", col_softcore)]
df_shell <- filtered_gene_absence[ , c("source_file", col_shell)]
df_cloud <- filtered_gene_absence[ , c("source_file", col_cloud)]

# Write new tables with core and accessory genomes
write.table(df_core, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_turicensis_core_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_softcore, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_turicensis_softcore_genome.tsv",  sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_shell, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_turicensis_shell_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_cloud, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_turicensis_cloud_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


# [C. MUYTJENSII]
# Read in filtered gene absence table file
data_read <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/muytjensii_gene_absence.tsv", sep = "\t", header = TRUE)
filtered_gene_absence <- as.data.frame(data_read)

# Calculation of column sum (without first column "source_file")
col_sum <- colSums(filtered_gene_absence[ , -1])
nr_muy <- nrow(filtered_gene_absence)

# Filter columns with column sum above 99.9% and below (core and accessory) - Number of samples = 48
col_core <- names(col_sum[col_sum >= 0.999 * nr_muy])
col_softcore <- names(col_sum[col_sum < 0.999 * nr_muy & col_sum >= 0.95 * nr_muy])
col_shell <- names(col_sum[col_sum < 0.95 * nr_muy & col_sum > 0.10 * nr_muy])
col_cloud <- names(col_sum[col_sum < 0.1 * nr_muy & col_sum > 0])

# New data frames with selected columns
df_core <- filtered_gene_absence[ , c("source_file", col_core)]
df_softcore <- filtered_gene_absence[ , c("source_file", col_softcore)]
df_shell <- filtered_gene_absence[ , c("source_file", col_shell)]
df_cloud <- filtered_gene_absence[ , c("source_file", col_cloud)]

# Write new tables with core and accessory genomes
write.table(df_core, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_muytjensii_core_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_softcore, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_muytjensii_softcore_genome.tsv",  sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_shell, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_muytjensii_shell_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_cloud, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_muytjensii_cloud_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


# [C. UNIVERSALIS]
# Read in filtered gene absence table file
data_read <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/universalis_gene_absence.tsv", sep = "\t", header = TRUE)
filtered_gene_absence <- as.data.frame(data_read)

# Calculation of column sum (without first column "source_file")
col_sum <- colSums(filtered_gene_absence[ , -1])
nr_uni <- nrow(filtered_gene_absence)

# Filter columns with column sum above 99.9% and below (core and accessory) - Number of samples = 19
col_core <- names(col_sum[col_sum >= 0.999 * nr_uni])
col_softcore <- names(col_sum[col_sum < 0.999 * nr_uni & col_sum >= 0.95 * nr_uni])
col_shell <- names(col_sum[col_sum < 0.95 * nr_uni & col_sum > 0.10 * nr_uni])
col_cloud <- names(col_sum[col_sum < 0.1 * nr_uni & col_sum > 0])

# New data frames with selected columns
df_core <- filtered_gene_absence[ , c("source_file", col_core)]
df_softcore <- filtered_gene_absence[ , c("source_file", col_softcore)]
df_shell <- filtered_gene_absence[ , c("source_file", col_shell)]
df_cloud <- filtered_gene_absence[ , c("source_file", col_cloud)]

# Write new tables with core and accessory genomes
write.table(df_core, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_universalis_core_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_softcore, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_universalis_softcore_genome.tsv",  sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_shell, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_universalis_shell_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_cloud, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_universalis_cloud_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)


# [C. CONDIMENTI]
# Read in filtered gene absence table file
data_read <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/condimenti_gene_absence.tsv", sep = "\t", header = TRUE)
filtered_gene_absence <- as.data.frame(data_read)

# Calculation of column sum (without first column "source_file")
col_sum <- colSums(filtered_gene_absence[ , -1])
nr_con <- nrow(filtered_gene_absence)

# Filter columns with column sum above 99.9% and below (core and accessory) - Number of samples = 5
col_core <- names(col_sum[col_sum >= 0.999 * nr_con])
col_softcore <- names(col_sum[col_sum < 0.999 * nr_con & col_sum >= 0.95 * nr_con])
col_shell <- names(col_sum[col_sum < 0.95 * nr_con & col_sum > 0.10 * nr_con])
col_cloud <- names(col_sum[col_sum < 0.1 * nr_con & col_sum > 0])

# New data frames with selected columns
df_core <- filtered_gene_absence[ , c("source_file", col_core)]
df_softcore <- filtered_gene_absence[ , c("source_file", col_softcore)]
df_shell <- filtered_gene_absence[ , c("source_file", col_shell)]
df_cloud <- filtered_gene_absence[ , c("source_file", col_cloud)]

# Write new tables with core and accessory genomes
write.table(df_core, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_condimenti_core_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_softcore, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_condimenti_softcore_genome.tsv",  sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_shell, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_condimenti_shell_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
write.table(df_cloud, file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/Cr_condimenti_cloud_genome.tsv", sep = "\t", quote = FALSE, row.names = FALSE)
