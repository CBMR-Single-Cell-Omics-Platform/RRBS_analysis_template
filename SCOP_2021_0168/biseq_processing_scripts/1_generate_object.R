# R script to read bismark-output files and save the created RRBS_raw object in the out-dir

library(BiSeq)
library(stringr)
library(betareg)
out_dir <- "/home/people/thokoe/data/SCOP_2021_0168/data/biseq_output"

## -------------------------------------------------------------------------------------------
col_data <- readxl::read_xlsx("~/data/SCOP_2021_0168/data/biseq_processing_scripts/combined.xlsx")
col_data$Sample.ID <- col_data$`Sample ID (Library ID)`

files_new <- gtools::mixedsort(list.files("~/data/SCOP_2021_0168/data/bismark_output/new", pattern = "*cov.gz", full.names = TRUE))
files_old <- gtools::mixedsort(list.files("~/data/SCOP_2021_0168/data/bismark_output/old", pattern = "*cov.gz", full.names = TRUE))
files <- c(files_new, files_old)

names(files) <- str_remove_all(string = basename(files),
                               pattern = "_S[[:digit:]]+_R[[:digit:]]+_001.UMI_trimmed.fq_trimmed_bismark_bt2.deduplicated.bismark.cov.gz")
rrbs_raw <- readBismark(unname(files[col_data$Sample.ID]), col_data)

saveRDS(rrbs_raw, file=file.path(out_dir, "rrbs_raw.RDS"))

cov_stat <- do.call(covStatistics(rrbs_raw), what = "rbind")
colnames(cov_stat) <- rrbs_raw$Sample.ID
write.csv(cov_stat, file = file.path(out_dir, "coverage_statistics.csv"))

pdf(file.path(out_dir, "coverage_boxplot_pre_smooth.pdf"))
covBoxplots(rrbs_raw, col = "cornflowerblue", las = 2)
dev.off()