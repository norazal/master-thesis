# [1] Set needed libraries
library(vegan)
library(data.table)
library(readr)
library(dplyr)
library(tibble)
library(ggplot2)

# [2] Import of data "iris"-data
data(iris)
head(iris)

# [3] Selection of certain columns
daten <- iris[ , -5]
species <- iris[ , c("Species")]

species_chr <- as.character(species)
str(species_chr)

# [4] Bray Curtis on "iris"-data
bc_iris <- vegdist(daten, method = "bray")

print(head(as.matrix(bc_iris))[1:5, 1:5])

# [5] PCoA on Bray Curtis Matrix
pcoa_iris <- cmdscale(bc_iris, k=2, eig = TRUE, add = TRUE)

positions_iris <- pcoa_iris$points
colnames(positions_iris) <- c("PCoA1", "PCoA2")

perex_iris <- 100 * pcoa_iris$eig / sum(pcoa_iris$eig)
# Calculation proportion of variance for first two axes
pco1_variance <- round(perex_iris[1], 2)
pco2_variance <- round(perex_iris[2], 2)


# [6] Merging of PCoA-scores with meta data
iris_scores <- as.data.frame(positions_iris) %>%
  rownames_to_column(var = "Number")

species_col <- species_chr %>%
  as.data.frame(species_chr) %>%
  mutate(Number = row_number()) %>%
  mutate(Number = as.character(Number))

plot_iris <- left_join(iris_scores, species_col, by = "Number")

colnames(plot_iris) <- c("Number", "PCoA1", "PCoA2", "Species")
head(species_col)
head(plot_iris)

# [7] Plotting with ggplot2

p <- ggplot(plot_iris, aes(x = PCoA1, y = PCoA2)) +
  geom_point(aes(color = Species),
             size = 3, alpha = 0.6) +
  stat_ellipse(aes(group = Species, color = Species),
               type = "norm", level = 0.95, linewidth = 0.9, linetype = "dashed") +
  labs(
    title = "PCoA based on Bray-Curtis-Distance",
    subtitle = "Iris Data",
    x = paste0("PCo1 (", pco1_variance, "%)"),
    y = paste0("PCo2 (", pco2_variance, "%)")
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 30, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 24),
    legend.position = "right",
    panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.1)
  ) +
  #scale_color_viridis_d(option = "D", name = "Species") +
  #scale_shape_manual(values = c(16, 17, 18, 15, 19), name = "Sources") +
  coord_fixed(ratio = 1)

print(p)
ggsave("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio PCoA/plot_iris.png", width = 16, height = 8, dpi = 300)

