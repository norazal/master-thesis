################ Filter out C. sakazakii and Other from master metadata table ##########################

library(dplyr)

# [1] Filter out C. sakazakii and Other from metadata
# Read in filtered master metadata table file
mmd <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/filter_master_metadata.tsv", sep = "\t", header = TRUE)


# [Cronobacter spp. without Other and C. sakazakii]
# Filter out species "Other" and "C. sakazakii"
mmd_cspp <- mmd %>%
  filter(!Species %in% c("Other", "Cronobacter sakazakii"))

# Write new tsv-file for later purpose
path_file <- "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/wo_sakazakii_metadata.tsv"
write.table(mmd_cspp, file = path_file, sep = "\t", row.names = FALSE, quote = FALSE)

# [2] Filter out C. sakazakii and Other from wide table (genes)
# Read in wide table file
gene_orig <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_genes.tsv", sep = "\t", header = TRUE)

to_keep <- unique(mmd_cspp$ID_ND)

# Filter only matched ID's
filtered_gene <- gene_orig %>%
  filter(source_file %in% to_keep)

# Write new tsv-file
write.table(
  x = filtered_gene,
  file = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff_filter/wo_sakazakii_gene_filtered.tsv",
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)

###################### PERMANOVA without C. sakazakii and Other #################################

# [1] Set needed libraries
library(vegan)
library(data.table)
library(readr)
library(dplyr)
library(tibble)

# [2.1] Exclusion of column "source_file"
gene_filtered <- filtered_gene[, -1]


# [3] Defining data as 'numeric', since it is needed for Bray-Curtis
for (col_name_1 in names(gene_filtered)) {
  # Control if data in columns is already in numeric or integer
  if (!is.numeric(gene_filtered[[col_name_1]]) && !is.integer(gene_filtered[[col_name_1]])) {
    gene_filtered[[col_name_1]] <- as.numeric(gene_filtered[[col_name_1]])
  }
}

# [4] Calculation of Bray-Curtis-distance (takes approx. 10 minutes)
bc_wo_sakazakii <- vegdist(gene_filtered, method = "bray")

# Checking Bray-Curtis-distance matrix
print(head(as.matrix(bc_wo_sakazakii))[1:5, 1:5])


# [5] Hierarchic Clustering
hc_wo_sakazakii <- hclust(bc_wo_sakazakii, method = "ward.D2")
print(hc_wo_sakazakii)
plot(hc_wo_sakazakii, labels = FALSE)

# [6] Cut tree into cluster
clusters_wo <- cutree(hc_wo_sakazakii, h = 0.5)
cluster_wo_df <- data.frame(Cluster = factor(clusters_wo))

# [7] PERMANOVA
permanova_result_wo <- adonis2(bc_wo_sakazakii ~ Cluster, data = cluster_wo_df, permutations = 999)
print(permanova_result_wo)

# [Optional] Homogenität der Varianzen prüfen
bd_wo <- betadisper(bc_wo_sakazakii, cluster_wo_df$Cluster)
anova(bd_wo)

plot(bd_wo)

tuk_wo <- TukeyHSD(bd_wo)
tuk_wo

##############[Cluster plot merged with metadata]#######################################

# [1] Insertion of rownames in both dataframes
cluster_wo_dataframe <- data.frame(
  ID = rownames(filtered_gene), 
  Cluster = factor(clusters_wo)
)

mmd_cspp$ID <- rownames(mmd_cspp)


# [2] Merging clusters with metadata
merged_wo <- merge(cluster_wo_dataframe, mmd_cspp, by = "ID")

head(merged_wo)

# [3] Loading required packages 
library(dplyr)
library(ggplot2)

# [4] Preparing data, if necessary (NA -> "Other", "Cronobacter ..." -> "C. ...")
plot <- merged_wo %>%
  mutate(
    Species = ifelse(is.na(Species) | Species == "", "Other", Species),
    Species = sub("^Cronobacter\\s+", "C. ", Species),
    Cluster = factor(Cluster)
  )

# [5] Count sums and complete empty values with 0
sum_df <- plot %>%
  count(Species, Cluster, name = "n") %>%
  complete(Species, Cluster, fill = list(n = 0))

# [6] Sort species according to their sum
species_order <- sum_df %>%
  group_by(Species) %>% summarise(n_tot = sum(n), .groups = "drop") %>%
  arrange(desc(n_tot)) %>% pull(Species)

sum_df <- sum_df %>% mutate(Species = factor(Species, levels = species_order))

# [7] Plotting with labels: grouped bins with labels
pd <- position_dodge(width = 0.8)

cluster_plot <- ggplot(sum_df, aes(x = Cluster, y = n, fill = Species)) +
  geom_col(position = pd, width = 0.7) +
  geom_text(
    aes(label = n),
    position = position_dodge(width = 0.8),
    vjust = -0.6, size = 5.0
  ) +
  labs(
    x = "Cluster", y = "Frequency", fill = "Species"
  ) +
  scale_y_continuous(expand = expansion(mult = c(0.02, 0.12))) +
  theme_classic(base_size = 16) +
  theme(
    panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.1),
    axis.text.x = element_text(size = 14),
    axis.text.y = element_text(size = 14)
  )

cluster_plot

ggsave(
  "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/MA plots/cluster_wo.png",
  width = 16, height = 8, dpi = 300
)