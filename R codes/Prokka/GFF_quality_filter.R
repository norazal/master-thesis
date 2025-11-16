# [1] Load needed libraries
library(readr)
library(dplyr)

# [2] Load wide table (product) - absence/presence
table_abs <- read_tsv("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff/wide_product_absence.tsv", col_names = TRUE)

# [3] Select 5S-, 16S- and 23S ribosomal RNA columns
rRNA_cols <- c("5S ribosomal RNA", "16S ribosomal RNA", "23S ribosomal RNA")

# [4] Calculate row sums for selected columns
table_abs <- table_abs %>%
  mutate(rRNA_sum = rowSums(select(., all_of(rRNA_cols)), na.rm = TRUE))

# [5] Mapping of amino acids
aa_map <- list(
  Ala = c("tRNA-Ala(ggc)", "tRNA-Ala(tgc)"),
  Arg = c("tRNA-Arg(acg)", "tRNA-Arg(ccg)", "tRNA-Arg(cct)", "tRNA-Arg(tct)"),
  Asn = c("tRNA-Asn(gtt)"),
  Asp = c("tRNA-Asp(gtc)"),
  Cys = c("tRNA-Cys(gca)"),
  Gln = c("tRNA-Gln(ctg)", "tRNA-Gln(ttg)"),
  Glu = c("tRNA-Glu(ttc)"),
  Gly = c("tRNA-Gly(ccc)", "tRNA-Gly(gcc)", "tRNA-Gly(tcc)"),
  His = c("tRNA-His(gtg)"),
  Ile = c("tRNA-Ile(gat)"),
  Leu = c("tRNA-Leu(caa)", "tRNA-Leu(cag)", "tRNA-Leu(gag)", 
          "tRNA-Leu(taa)", "tRNA-Leu(tag)"),
  Lys = c("tRNA-Lys(ttt)"),
  Met = c("tRNA-Met(cat)"),
  Phe = c("tRNA-Phe(gaa)"),
  Pro = c("tRNA-Pro(cgg)", "tRNA-Pro(ggg)", "tRNA-Pro(tgg)"),
  Ser = c("tRNA-Ser(cga)", "tRNA-Ser(gct)", "tRNA-Ser(gga)", "tRNA-Ser(tga)"),
  Thr = c("tRNA-Thr(cgt)", "tRNA-Thr(ggt)", "tRNA-Thr(tgt)"),
  Trp = c("tRNA-Trp(cca)"),
  Tyr = c("tRNA-Tyr(gta)"),
  Val = c("tRNA-Val(gac)", "tRNA-Val(tac)")
)

# [6] Using only maximum value per amino acid (because of multiple possibilities)
for (aa in names(aa_map)) {
  cols <- aa_map[[aa]]
  existing <- cols[cols %in% colnames(table_abs)]  # only taking existing columns
  if (length(existing) > 0) {
    table_abs[[aa]] <- apply(table_abs[existing], 1, function(x) max(as.numeric(x), na.rm = TRUE))
  } else {
    table_abs[[aa]] <- 0
  }
}

# [7] Calculating row sums of all 20 amino acids
table_abs <- table_abs %>%
  mutate(amino_acids = rowSums(select(., all_of(names(aa_map))), na.rm = TRUE))

# [8] Filter all rows that have rRNA sum > 3 and at least 18 amino acids coded
table_filtered <- table_abs %>%
  filter(rRNA_sum > 0, amino_acids >= 18)

# [9] Keep relevant columns - insert "source_file" as first column
result <- table_filtered %>%
  select(source_file, all_of(rRNA_cols), rRNA_sum, names(aa_map), amino_acids)

# [10] Write new tsv-file
write_tsv(result, "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff_filter/gff_quality_filtered.tsv")

# [11] Take column "source_file" from new written tsv-file
source_keep <- read_tsv("C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff_filter/gff_quality_filtered.tsv") %>%
  pull(source_file)

# [12] Filter out filtered rows from original tsv-file
original_filtered <- table_abs %>%
  filter(source_file %in% source_keep)

# [13] Write new filtered absence/presence(product)-file
write_tsv(original_filtered, "C:/A-Benutzerdateien/BOKU/5. Semester/Master Thesis (Cronobacter)/Tabellen (2025)/RStudio gff_filter/product_absence_filtered.tsv")