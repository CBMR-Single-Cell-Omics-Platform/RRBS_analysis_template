library(BiSeq)
library(stringr)
library(betareg)
out_dir <- "/home/people/thokoe/data/SCOP_2021_0168/data/biseq_output"

# -------------------------------------------------------------------------
predicted_meth <- readRDS(file.path(out_dir, "predicted_meth.RDS"))
# -------------------------------------------------------------------------

# get indices of each group
is_high <- which(predicted_meth$group=="H")
is_low <- which(predicted_meth$group=="L")

# reorder object so it contains unbroken strings of same group
predictedMethNull <- predicted_meth[,c(is_high,is_low)]

# make a variable = group.null with equal number of each condition
rand_vector <- rep(c(1,2), ncol(predictedMethNull))[1:ncol(predictedMethNull)]
colData(predictedMethNull)$group.null <- rand_vector

# run null regression
betaResultsNull <- betaRegression(formula = ~group.null,
                                  link = "probit",
                                  object = predictedMethNull,
                                  type="BR", mc.cores = 40)

# -------------------------------------------------------------------------
saveRDS(betaResultsNull, file=file.path(out_dir, "beta_results_null_grouped.RDS"))
# -------------------------------------------------------------------------


