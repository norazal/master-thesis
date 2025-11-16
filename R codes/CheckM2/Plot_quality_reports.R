# [1] Preparation of packages
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
if (!requireNamespace("patchwork", quietly = TRUE)) {
  install.packages("patchwork")
}
if (!requireNamespace("ggExtra", quietly = TRUE)) {
  install.packages("ggExtra")
}


library(ggplot2)
#library(patchwork)
library(ggExtra)

# [1] Set working directory
setwd("C:\\A-Benutzerdateien\\BOKU\\5. Semester\\Master Thesis (Cronobacter)\\Tabellen (2025)\\RStudio quality reports\\")

quality_report <- read.table("full_quality_report.tsv", header = TRUE, sep = "\t")

# [2] Plot creation
meta_plot <- ggplot(quality_report, aes(x = Completeness, y = Contamination)) +
  geom_point(color = "darkgreen", size = 1, alpha = 0.4) +
  geom_vline(xintercept = 90, color = "darkred", linetype = "dashed") +
  geom_hline(yintercept = 5, color = "darkred", linetype = "dashed") +
  labs(
    x = "CheckM2 - Completeness (%)",
    y = "CheckM2 - Contamination (%)"
  ) +
  theme_classic() +
  theme(
    panel.background = element_rect(fill = "white"),
    panel.grid.major = element_line(color = "grey", size = 0.6),
    panel.grid.minor = element_line(color = "grey", size = 0.3),
    axis.text.x = element_text(size = 14),
    axis.text.y = element_text(size = 14),
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16)
  )

plot_marg <- ggMarginal(meta_plot, type = "histogram", bins = 100) 
  
#contamination_hist <- ggplot(quality_report, aes(x = Contamination)) +
#  geom_histogram(binwidth = 0.5, fill = "lightblue", color = "black") +
#  labs(x = "Contamination (%)", y = "Count") + # Labels for histogram
#  theme_classic() +
#  coord_flip()

#combined_plot <- meta_plot + contamination_hist +
#  plot_layout(widths = c(2, 1)) # Adjust ratio of width with 3 units for scatter plot, 1 unit for histogram

#print(combined_plot)
ggsave("plot_quality_reports(new).png", plot = plot_marg, width = 10, height = 8, dpi = 300)
