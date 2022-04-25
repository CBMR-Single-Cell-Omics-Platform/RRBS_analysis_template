# Bulk_RNA_seq_analysis_template

A template for analyzing a Universal Plus mRNA-seq with Nuquant project using EdgeR.

The analysis itself is written in the form a .Rmd-file, which contains both code and interactive output for the user.

**Contents:**

-   **data-raw:** This is where the raw transcript/gene counts are stored. Can be large files, which is not meant to be uploaded to the user, but only used for the analyses. Is by default ignored by git to prevent large files being uploaded.

-   **SCOP_2022_XXXX:** This is the local working directory where the actual analysis takes place. If more tissues/analyses are made, there will be several relevant sub-directories of this.

    -   **analysis.Rmd:** The template .Rmd-analysis, which contains basic analysis routine. When you knit the file, an .html-output with the corresponding name and today's date will be automatically generated, as well as a directory containing relevant outputs tied to the analysis.

    -   **data-raw:** Similar to the data directory another-level up, but is meant to be used if the raw data is managable in size so that the full analysis can be run by the user.

-   **old_or_extra:** Mean to store stuff in if the working directory gets cluttered, but you don't want to delete stuff.

**Upon completion of analysis:**

1.  Make a copy of the SCOP_2022_XXXX working dir

2.  Sanitize it by removing all non-relevant files for the user. But it should still be able to run perfectly (except if missing raw-data in the case that it is large and stored in the outer data-raw folder).

3.  Append the date-of-handin to the folder-name

4.  Zip it

5.  Send via e-mail or filesender

6.  Upload a local copy of the whole directory to the relevant project-dir with data appended to it
