/scratch/SCOP/nextflow run /scratch/SCOP/nextflow_pipelines/nf-core-rnaseq-3.6/workflow \
--input nextflow_sample_sheet.csv \
--genome GRCm38 \
--max_cpus 20 \
--max_memory 196.GB \
--outdir ../03_PipelineOut \
--with_umi \
--umitools_bc_pattern NNNNNNNN \
-profile singularity
