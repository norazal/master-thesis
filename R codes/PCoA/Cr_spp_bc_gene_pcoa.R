# [1] Set needed libraries
library(vegan)
library(data.table)
library(readr)
library(dplyr)
library(tibble)
library(ggplot2)

# [2] Import of data 
# Read tsv-file "wide_gene.tsv"
wide_gene <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff_filter/gene_filtered.tsv", sep = "\t", header = TRUE)
gene_df <- as.data.frame(wide_gene)

# [2.1] Exclusion of column "source_file" and columns, in which number of value = 0 are more than 90% of all entries
# gene_filtered <- gene_df[, -1][, colSums(gene_df != 0) > 0.1 * 3990]

# [2.1 alternate] Exclusion of column "source_file" only
gene_filtered <- gene_df[, -1]

# [3] Defining data as 'numeric', since it is needed for Bray-Curtis
for (col_name_1 in names(gene_filtered)) {
  # Control if data in columns is already in numeric or integer
  if (!is.numeric(gene_filtered[[col_name_1]]) && !is.integer(gene_filtered[[col_name_1]])) {
    gene_filtered[[col_name_1]] <- as.numeric(gene_filtered[[col_name_1]])
  }
}

# [4] Calculation of Bray-Curtis-distance (takes approx. 10 minutes)
bc_dist_gene_all <- vegdist(gene_filtered, method = "bray")

# Checking Bray-Curtis-distance matrix
print(head(as.matrix(bc_dist_gene_all))[1:5, 1:5])

# [5] PCoA with cmdscale (approx. 25 minutes)
pcoa_cmd_gene_all <- cmdscale(bc_dist_gene_all, k=2, eig = TRUE, add = TRUE)

positions <- pcoa_cmd_gene_all$points
colnames(positions) <- c("PCoA1", "PCoA2")

# Calculating explained variances
percent_explained <- 100 * pcoa_cmd_gene_all$eig / sum(pcoa_cmd_gene_all$eig)


# [6] Extraction of coordinates (scores) for ggplot2
pcoa_scores <- as.data.frame(positions) %>%
  rownames_to_column(var = "Number")

# Reading meta data table
f_metadata <- fread("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/filter_master_metadata.tsv", sep = "\t", header = TRUE)
f_data <- f_metadata %>%
  mutate(Number = row_number()) %>%
  mutate(Number = as.character(Number))

# Merging of PCoA-scores with meta data
pcoa_for_plot_gene <- left_join(pcoa_scores, f_data, by = "Number")

# Calculation proportion of variance for first two axes
pco1_variance <- round(percent_explained[1], 2)
pco2_variance <- round(percent_explained[2], 2)

# [7] Plotting with ggplot2
p <- ggplot(pcoa_for_plot_gene, aes(x = PCoA1, y = PCoA2)) +
  geom_point(aes(color = Species),
             size = 1.5, alpha = 0.5) +
  stat_ellipse(aes(group = Species, color = Species),
               type = "norm", level = 0.95, linewidth = 0.4, linetype = "dashed") +
  labs(
    title = "PCoA based on Bray-Curtis-Dissimilarity",
    subtitle = "Cronobacter spp. - Gene",
    x = paste0("PCo1 (", pco1_variance, "%)"),
    y = paste0("PCo2 (", pco2_variance, "%)")
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 24, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 18),
    axis.title = element_text(size = 16),                     
    axis.text = element_text(size = 14),                      
    legend.title = element_text(size = 16, face = "bold"),    
    legend.text = element_text(size = 14), 
    legend.position = "right",
    panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.1)
  ) +
  coord_fixed(ratio = 1)

print(p)
ggsave("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio PCoA/plot_crspp_pcoa_bc_gene_all.png", width = 16, height = 8, dpi = 300)

