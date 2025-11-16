# Libraries

library(data.table)   
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(purrr)

# Read in files
files <- c(
  "sakazakii"    = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/sakazakii_gene_absence.tsv",
  "malonaticus"  = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/malonaticus_gene_absence.tsv",
  "dublinensis"  = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/dublinensis_gene_absence.tsv",
  "turicensis"   = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/turicensis_gene_absence.tsv",
  "muytjensii"   = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/muytjensii_gene_absence.tsv",
  "universalis"  = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/universalis_gene_absence.tsv",
  "condimenti"   = "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/condimenti_gene_absence.tsv"
)

bin_breaks <- c(0.0001, 0.10, 0.95, 0.999, 1.0)
bin_labels <- c("cloud genes and singletons", "shell genes", "softcore genes", "core genes")
bin_order  <- c("core genes", "softcore genes", "shell genes", "cloud genes and singletons")
fill_cols  <- c("core genes"="darkgreen","softcore genes"="lightgreen",
                "shell genes"="orange","cloud genes and singletons"="lightblue")

# Function to support:
summarize_species <- function(path, species_label) {
  df <- fread(path, header = TRUE, sep = "\t")
  cspp <- as.data.frame(df[ , -1])  # exclude first column (ID)
  
  cspp[] <- lapply(cspp, function(x) if (is.numeric(x) || is.integer(x)) as.numeric(x) else as.numeric(x))
  
  gene_freq <- colSums(cspp, na.rm = TRUE) / nrow(cspp)
  
  bins <- cut(
    gene_freq,
    breaks = bin_breaks,
    labels = bin_labels,
    include.lowest = TRUE,
    right = TRUE
  )
  
  freq_table <- as.data.frame(table(bins), stringsAsFactors = FALSE)
  freq_table$bins <- factor(freq_table$bins, levels = bin_order)
  
  n_samples <- nrow(cspp)
  n_cols_inplot <- sum(colSums(cspp, na.rm = TRUE) > 0)
  
  freq_table %>%
    mutate(
      species      = str_c("C. ", species_label,
                           " (", n_samples, " genomes; ", n_cols_inplot, " genes)"),
      n_samples    = n_samples,
      n_cols_inplot= n_cols_inplot
    )
}

# Mapping all spezies into a dataframe
all_freq <- imap_dfr(files, ~ summarize_species(.x, .y))

# Defining text position
all_freq_labels <- all_freq %>%
  group_by(species) %>%
  mutate(
    cumFreq = cumsum(Freq) - (Freq / 2),      # for middle position in bars
    totalGenes = unique(n_cols_inplot)        
  )


# Keeping values in bins >0
all_freq_labels_nonzero <- all_freq_labels %>%
  filter(Freq > 0)

all_freq_labels_nonzero <- all_freq_labels_nonzero %>%
  mutate(species_clean = sub(" \\(.*\\)$", "", species))

# Text labels above the bins
n_labels_df <- all_freq_labels_nonzero %>%
  distinct(species_clean, n_samples, n_cols_inplot) %>%
  mutate(
    label_text = paste0("n = ", n_samples, "\nTotal: ", n_cols_inplot, " genes"),
    y_pos = n_cols_inplot + 0.03 * max(all_freq_labels_nonzero$Freq)  # etwas über Balken
  )

# Sorting order
species_order <- all_freq_labels_nonzero %>%
  group_by(species_clean) %>%
  summarise(n_samples = unique(n_samples)) %>%
  arrange(desc(n_samples)) %>%       
  pull(species_clean)

# Adapting factor levels to order
all_freq_labels_nonzero$species_clean <- factor(all_freq_labels_nonzero$species_clean, levels = species_order)
n_labels_df$species_clean <- factor(n_labels_df$species_clean, levels = species_order)


# Colors for consistency
fill_cols  <- c("core genes"="lightgreen",
                "softcore genes"="orange",
                "shell genes"="yellow",
                "cloud genes and singletons"="lightblue")

# Plotting
p_stack_n <- ggplot(all_freq_labels_nonzero, aes(x = species_clean, y = Freq, fill = bins)) +
  geom_col(position = "stack", width = 0.6) +
  
  geom_text(aes(y = cumFreq, label = Freq),
            color = "black", size = 5, fontface = "bold") +
  
  geom_text(
    data = n_labels_df,
    aes(x = species_clean, y = y_pos, label = label_text),
    inherit.aes = FALSE,
    size = 4.5, fontface = "bold",
    lineheight = 0.9,       
    hjust = 0.5,            
    vjust = 0                
  ) +
  
  scale_fill_manual(values = fill_cols, name = "Category") +
  labs(
    title = "Cronobacter – Core and accessory genes distribution",
    x = NULL,
    y = "Gene Count"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 22, face = "bold"),
    legend.title = element_text(size = 16, face = "bold"),  
    legend.text = element_text(size = 14),
    axis.text.x = element_text(angle = 30, hjust = 1, size = 13),
    axis.text.y = element_text(size = 13)
  )

print(p_stack_n)

ggsave("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio core_accessory/freq_all_species_n_total_above.png",
       p_stack_n, width = 16, height = 10, dpi = 300)