library(BiSeq)
library(stringr)
library(betareg)
out_dir <- "/home/people/thokoe/data/SCOP_2021_0168/data/biseq_output"

# -------------------------------------------------------------------------
rrbs_clust_lim <- readRDS(file.path(out_dir, "rrbs_clust_lim.RDS"))
# -------------------------------------------------------------------------

predicted_meth <- predictMeth(object = rrbs_clust_lim, mc.cores = 40)

saveRDS(predicted_meth, file.path(out_dir, "predicted_meth.RDS"))
# pdf(file.path(out_dir, "smoothed_methylation_plot.pdf"))
# plotMeth(object.raw = rrbs_raw[,1],
         # object.rel = predicted_meth[,1],
         # region = clusters[1],
         # lwd.lines = 2,
         # col.points = "blue",
         # cex = 1.5)
# dev.off()


# -------------------------------------------------------------------------
saveRDS(predicted_meth, file.path(out_dir, "predicted_meth.RDS"))
# -------------------------------------------------------------------------


