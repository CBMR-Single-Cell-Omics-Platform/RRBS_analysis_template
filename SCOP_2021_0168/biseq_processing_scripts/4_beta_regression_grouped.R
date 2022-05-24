library(BiSeq)
library(stringr)
library(betareg)
out_dir <- "/home/people/thokoe/data/SCOP_2021_0168/data/biseq_output"

# -------------------------------------------------------------------------
predicted_meth <- readRDS(file.path(out_dir, "predicted_meth.RDS"))
# -------------------------------------------------------------------------

beta_results_grouped <- betaRegression(formula = ~ group,
                                      link = "probit",
                                      object = predicted_meth,
                                      type = "BR",
                                      mc.cores = 40)


# -------------------------------------------------------------------------
saveRDS(beta_results_grouped, file.path(out_dir,"beta_results_grouped.RDS"))
# -------------------------------------------------------------------------


