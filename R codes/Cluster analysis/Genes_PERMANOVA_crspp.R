# [1] Set needed libraries
library(vegan)
library(data.table)
library(readr)
library(dplyr)
library(tibble)

# [2] Import of data 
# Read tsv-file "without_Other_gene_filtered.tsv"
wide_gene <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff_filter/without_Other_gene_filtered.tsv", sep = "\t", header = TRUE)
gene_df <- as.data.frame(wide_gene)

# [2.1] Exclusion of column "source_file"
gene_filtered <- gene_df[, -1]

# [3] Defining data as 'numeric', since it is needed for Bray-Curtis
for (col_name_1 in names(gene_filtered)) {
  # Control if data in columns is already in numeric or integer
  if (!is.numeric(gene_filtered[[col_name_1]]) && !is.integer(gene_filtered[[col_name_1]])) {
    gene_filtered[[col_name_1]] <- as.numeric(gene_filtered[[col_name_1]])
  }
}

# [4] Calculation of Bray-Curtis-distance (takes approx. 10 minutes)
bc_dist_gene <- vegdist(gene_filtered, method = "bray")

# Checking Bray-Curtis-distance matrix
print(head(as.matrix(bc_dist_gene))[1:5, 1:5])

# [5] Hierarchic Clustering
hc_gene <- hclust(bc_dist_gene, method = "ward.D2")
print(hc_gene)
plot(hc_gene, labels = FALSE)

# png("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio statistics/dendogram_bc_gene_wardD2.png", width = 160, height = 120)
dev.off()

# [6] Cut tree into cluster
clusters <- cutree(hc_gene, h = 0.8)
cluster_md <- data.frame(Cluster = factor(clusters))

# [7] PERMANOVA
permanova_result <- adonis2(bc_dist_gene ~ Cluster, data = cluster_md, permutations = 999)
print(permanova_result)

# [Optional] Check of homogeneity of variances
bd <- betadisper(bc_dist_gene, cluster_md$Cluster)
anova(bd)

plot(bd)

tuk <- TukeyHSD(bd)
tuk

##############[Cluster plot merged with metadata]#######################################

cluster_df <- data.frame(
  ID = rownames(gene_df), 
  Cluster = factor(clusters)
  )

# [1] Read in meta data table
metadata <- read.delim("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/Filtered Metadata/without_Other_metadata.tsv", sep = "\t", header = TRUE)
metadata$ID <- rownames(metadata)


# [2] Merging clusters with metadata
merged_df <- merge(cluster_df, metadata, by = "ID")

head(merged_df)

# [3] Loading required packages 
library(dplyr)
library(ggplot2)

# [4] Preparing data, if necessary (NA -> "Other", "Cronobacter ..." -> "C. ...")
plot_df <- merged_df %>%
  mutate(
    Species = ifelse(is.na(Species) | Species == "", "Other", Species),
    Species = sub("^Cronobacter\\s+", "C. ", Species),
    Cluster = factor(Cluster)
  )

# [5] Count sums and complete empty values with 0
sum_df <- plot_df %>%
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
  "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/MA plots/cluster.png",
  width = 16, height = 8, dpi = 300
)