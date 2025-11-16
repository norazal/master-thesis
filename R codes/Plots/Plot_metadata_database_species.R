# libraries
library(readr)
library(dplyr)
library(ggplot2)
library(forcats)

# read in data
df <- read_tsv("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/filter_master_metadata.tsv", col_types = cols())

# preparing data
df_clean <- df %>%
  mutate(
    Species = ifelse(is.na(Species), "Other", Species),
    Species = gsub("^Cronobacter\\s+", "C. ", Species)
  )

# calculating absolut counts
species_count <- df_clean %>%
  count(Species, name = "n") %>%
  mutate(
    rel = n / sum(n) * 100,
    label = paste0(n, " (", sprintf("%.1f", rel), "%)")
  )

# Plot:
plot1 <- ggplot(species_count, aes(x = fct_reorder(Species, n), y = n, fill = Species)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = label), vjust = -0.5, size = 5.0) +
  labs(
    x = "Species",
    y = "Frequency"
  ) +
  theme_classic(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.1)
  )

plot1

ggsave("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/MA plots/freq_distribution.png", width = 12, height = 8, dpi = 300)
