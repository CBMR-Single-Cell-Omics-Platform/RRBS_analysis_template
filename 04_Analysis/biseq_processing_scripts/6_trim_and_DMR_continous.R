# Data Loading ------------------------------------------------------------
library(BiSeq)
library(stringr)
library(betareg)
out_dir <- "biseq_output"

## Continous -------------------------------------------------------------------------------------------
betaResultsNull<- readRDS(file.path(out_dir, "beta_results_null_continous.RDS"))
beta_results <- readRDS(file.path(out_dir, "beta_results_continous.RDS"))

# make variogram
vario <- makeVariogram(betaResultsNull)
pdf(file.path(out_dir, "variogram_continous.pdf"))
plot(vario$variogram$v)
dev.off()

# smooth variogram using sill
vario_sm <- smoothVariogram(vario, sill = 0.95)
pdf(file.path(out_dir,"variogram_combined_continous.pdf"))
plot(vario$variogram$v)
lines(vario_sm$variogram[,c("h", "v.sm")],
      col = "red", lwd = 1.5)
grid()
dev.off()

# testing and trimming clusters
vario_aux <- makeVariogram(beta_results, make.variogram=T)
vario_sm$pValsList <- vario_aux$pValsList
locCor <- estLocCor(vario_sm)
saveRDS(locCor, file=file.path(out_dir, "locCor_continous.RDS"))

clusters_rej <- testClusters(locCor, FDR.cluster = 0.1)
clusters_trimmed <- trimClusters(clusters_rej, FDR.loc = 0.05)
saveRDS(clusters_trimmed, file = file.path(out_dir,"clusters_trimmed_continous.RDS"))

# DMRs
DMRs <- findDMRs(clusters_trimmed,
                 max.dist = 100,
                 diff.dir = TRUE)

saveRDS(DMRs, file = file.path(out_dir,"DMRs_continous.RDS"))


