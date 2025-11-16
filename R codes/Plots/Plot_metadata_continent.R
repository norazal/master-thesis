# libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

# read in data
df <- read_tsv("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/filter_master_metadata.tsv", col_types = cols())

# defining order of continents
cont_levels <- c(
  "Africa",
  "Asia",
  "Europe",
  "North America",
  "South America",
  "Oceania",
  "Unknown"
)

# counting and fill in 0 values
counts <- df %>%
  mutate(
    Species   = gsub("^Cronobacter\\s+", "C. ", Species),
    Continent = factor(Continent, levels = cont_levels)
  ) %>%
  count(Species, Continent, name = "n") %>%
  complete(Species, Continent, fill = list(n = 0))   # fixe Slots je Spezies

# sort according to total number
species_order <- counts %>%
  group_by(Species) %>%
  summarise(total = sum(n), .groups = "drop") %>%
  arrange(desc(total)) %>%
  pull(Species)

counts <- counts %>% mutate(Species = factor(Species, levels = species_order))

# Plotting
p2 <- ggplot(counts, aes(x = Species, y = n, fill = Continent)) +
  geom_col(position = position_dodge(width = 0.9)) +
  geom_text(
    data = counts,
    aes(label = n, y = n),
    position = position_dodge(width = 0.9),
    vjust = 0.4, hjust = -0.5, angle = 90, size = 4.6, fontface = "bold"
  ) +
  labs(
    x = "Species", y = "Frequency", fill = "Continent",
  ) +
  scale_fill_discrete(drop = FALSE) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.14))) +
  coord_cartesian(clip = "off") +
  theme_classic(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.1)
  )

print(p2)

ggsave(
  "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/MA plots/freq_continent.png",
  width = 16, height = 8, dpi = 300
)