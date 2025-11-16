# libraries
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(forcats)

# read in data:
df <- read_tsv("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/master_metadata_final.tsv", col_types = cols())

# preparing data:
df_clean <- df %>%
  mutate(
    Species  = ifelse(is.na(Species), "Other", Species),
    Species  = gsub("^Cronobacter\\s+", "C. ", Species),
    Database = ifelse(Database %in% c("NCBI", "PubMLST"), Database, NA_character_)
  ) %>%
  # filter out NA if still contained
  filter(!is.na(Database))

# counting species according to database
counts <- df_clean %>%
  count(Database, Species, name = "n") %>%
  complete(Database = c("NCBI", "PubMLST"), Species, fill = list(n = 0))

# relative values
counts <- counts %>%
  group_by(Database) %>%
  mutate(total_db = sum(n),
         rel = ifelse(total_db > 0, 100 * n / total_db, 0)) %>%
  ungroup()

# order of species:
species_order <- counts %>%
  group_by(Species) %>% summarise(n_tot = sum(n), .groups = "drop") %>%
  arrange(desc(n_tot)) %>% pull(Species)

counts <- counts %>%
  mutate(
    Species = factor(Species, levels = species_order),
    y_val   = ifelse(Database == "NCBI", -n, n),
    label   = paste0(n, " (", sprintf("%.1f", rel), "%)")
  )


lim <- max(abs(counts$y_val))
pad <- max(2, 0.15 * lim)   

# Plot
p <- ggplot(counts, aes(x = Species, y = y_val, fill = Database)) +
  geom_col(width = 0.7, color = NA, show.legend = TRUE) +
  geom_text(
    aes(
      y = y_val,
      label = label,
      hjust = ifelse(Database == "NCBI", 1.05, -0.05)
    ),
    size = 4
  ) +
  geom_hline(yintercept = 0, linewidth = 0.6, colour = "grey35") +
  coord_flip(ylim = c(-(lim + pad), lim + pad)) +
  scale_y_continuous(labels = function(x) abs(x)) +
  labs(
    title = "Downloaded Cronobacter spp. genomes",
    subtitle = "Left: NCBI  |  Right: PubMLST",
    x = NULL,
    y = "Frequency"
  ) +
  theme_classic(base_size = 14) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(size = 14),
    legend.position = "top",
    
  )

p

ggsave("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/MA plots/freq_download.png", width = 12, height = 6, dpi = 300)
