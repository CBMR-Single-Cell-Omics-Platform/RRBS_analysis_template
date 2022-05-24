library(BiSeq)
library(stringr)
library(betareg)
out_dir <- "/home/people/thokoe/data/SCOP_2021_0168/data/biseq_output"


# -------------------------------------------------------------------------
rrbs_raw <- readRDS(file.path("/home/people/thokoe/data/SCOP_2021_0168/data/biseq_general_output/", "rrbs_raw.RDS"))
rrbs_raw$group <- ifelse(rrbs_raw$TADS>30, "H", "L")
# -------------------------------------------------------------------------

rrbs_clust_unlim <- clusterSites(object = rrbs_raw,
                                 groups = factor(rrbs_raw$group, levels=c("L","H")),
                                 perc.samples = 4/5,
                                 min.sites = 20,
                                 max.dist = 100)

clusters <- clusterSitesToGR(rrbs_clust_unlim)
saveRDS(clusters, file = file.path(out_dir, "clusters_GR.RDS"))


ind_cov <- totalReads(rrbs_clust_unlim) > 0
quant <- quantile(totalReads(rrbs_clust_unlim)[ind_cov], 0.9)

rrbs_clust_lim <- limitCov(rrbs_clust_unlim, maxCov = quant)

pdf(file.path(out_dir, "coverage_boxplot_post_smooth.pdf"))
covBoxplots(rrbs_clust_lim, col = "cornflowerblue", las = 2)
dev.off()


# -------------------------------------------------------------------------
saveRDS(rrbs_clust_lim, file.path(out_dir, "rrbs_clust_lim.RDS"))

# -------------------------------------------------------------------------


