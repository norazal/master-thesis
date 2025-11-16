# libraries
library(dplyr)
library(ggplot2)
library(readr)

# read in data
df <- read_tsv("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio tables/filter_master_metadata.tsv", col_types = cols()) %>%
  mutate(Year = as.integer(Year)) %>%
  filter(!is.na(Year))

# determining actual year
current_year <- as.integer(format(Sys.Date(), "%Y"))

# grouping 5 year periods
df_5yr <- df %>%
  mutate(
    interval_start = floor((Year) / 5) * 5,
    interval_end   = ifelse(interval_start == floor(current_year / 5) * 5,
                            current_year, interval_start + 4),
    Interval       = paste0(interval_start, "–", interval_end)
  ) %>%
  count(Interval)

# sorting order chronologically
df_5yr$Interval <- factor(df_5yr$Interval, levels = sort(unique(df_5yr$Interval)))

# Plot with absolute values
p_5yr <- ggplot(df_5yr, aes(x = Interval, y = n)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = n), vjust = -0.5, size = 5.5) +
  labs(
    x = NULL, y = "Frequency",
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.08))) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 14))

p_5yr

ggsave("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/MA plots/freq_year.png", width = 16, height = 8, dpi = 300)
