get_cpg_no_from_pos <- function(rrbs_object, chr, pos) {
#' # helper function to get cpg_no using its chromosome and position info
  which(seqnames(rrbs_object) == chr & start(rrbs_object) == pos)}

get_methylation_levels <- function(rrbs_object, cpg_no, meth.group1_indices, meth.group2_indices) {
  #' # helper function to get predicted methylation level using a given cpg_no
  meth.group1_levels <- assays(rrbs_object)$methLevel[cpg_no, meth.group1_indices]
  
  meth.group2_levels <- assays(rrbs_object)$methLevel[cpg_no, meth.group2_indices]
  
  return(list(meth.group1_levels, meth.group2_levels))
}

trim_iteratively <- function(locCor, FDR_vals) {
  
  clusters_rej <- testClusters(locCor, FDR.cluster = 0.1)
  trimmed_clusters_list <- lapply(FDR_vals, FUN= function(FDR_val) trimClusters(clusters_rej, FDR.loc = FDR_val)) %>% 
    setNames(FDR_vals)
  
  return(trimmed_clusters_list)
}

plot_clusters_list <- function(trimmed_clusters_list,FDR_vals_to_tested=FDR_vals) {
  significant_cpgs_by_FDR <- trimmed_clusters_list %>% 
    lapply(nrow) %>% 
    unlist() %>% 
    enframe(name="FDR threshold", value="No. significant elements")
  
  significant_clusters_by_FDR <- 
    trimmed_clusters_list %>% 
    lapply(dplyr::distinct, cluster.id) %>% 
    lapply(nrow) %>% unlist() %>% 
    enframe(name="FDR threshold", value="No. significant elements")
  
  plot <- bind_rows(CpGs=significant_cpgs_by_FDR, Clusters= significant_clusters_by_FDR, .id="Type") %>% 
    ggplot(aes(x=`FDR threshold`, y=`No. significant elements`, group=Type, color=Type)) +
    geom_line() +
    geom_point() +
    theme_bw()
  
  return(plot)
}
