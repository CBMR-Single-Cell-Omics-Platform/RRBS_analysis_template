# RRBS analysis template using Biseq

A template for analyzing RRBS results using Bismark & BiSeq.

The main analysis itself is written in the form a .Rmd-file, which contains both code and interactive output for the user.

**Purpose and contents of directories in this repository:**

-   **data-raw:** This is where raw data files that are too large to be handed over to the user exist. Is by default ignored by git to prevent large files being uploaded.

-   **SCOP_2022_XXXX:** This is the local working directory where the actual analysis takes place. If more tissues/analyses are made, there will be several relevant sub-directories of this.

-   **SCOP_2022_XXXX/analysis.Rmd:** The template .Rmd-analysis, which contains basic analysis routine. When you knit the file, an .html-output with the corresponding name and today's date will be automatically generated, as well as a directory containing relevant outputs tied to the analysis.

-   **SCOP_2022_XXXX/data-raw:** Similar to the data directory another-level up, but is meant to be used if the raw data is manageable in size so that the full analysis can be run by the user.
