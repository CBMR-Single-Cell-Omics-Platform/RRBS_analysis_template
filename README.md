# Bulk mRNA-seq analysis template using EdgeR

A template for analyzing a Universal Plus mRNA-seq with Nuquant using EdgeR.

The analysis itself is written in the form a .Rmd-file, which contains both code and interactive output for the user.

**Purpose and contents of directories in this repository:**

-   **data-raw:** This is where the raw transcript/gene counts are stored. Can be large files, which is not meant to be uploaded to the user, but only used for the analyses. Is by default ignored by git to prevent large files being uploaded.

-   **SCOP_2022_XXXX:** This is the local working directory where the actual analysis takes place. If more tissues/analyses are made, there will be several relevant sub-directories of this.

-   **SCOP_2022_XXXX/analysis.Rmd:** The template .Rmd-analysis, which contains basic analysis routine. When you knit the file, an .html-output with the corresponding name and today's date will be automatically generated, as well as a directory containing relevant outputs tied to the analysis.

-   **SCOP_2022_XXXX/data-raw:** Similar to the data directory another-level up, but is meant to be used if the raw data is manageable in size so that the full analysis can be run by the user.

-   **old_or_extra:** Mean to store stuff in if the working directory gets cluttered, but you don't want to delete stuff.

**Pre-processing steps before analysis:**

1.  On Yggdrasil, copy sequencing folder (name found in Trello) from seq-drive to SCOP-project dir (when mounted)

    ```{bash}
    mount_SCOP_share SCOP_2022_XXXX
    cp /data/SCOP/seq3/tqb695/XXXXXXXXX /data/SCOP/SCOP_2022_XXXX/tqb695/RNAseq/01_BCL/
    ```

2.  Move 01_BCL/SampleSheet.csv into sequencing folder

3.  `cp` **01_BCL_bcl2fastq.sh** into sequencing folder and run it

4.  `cd` into fastq-directory and run **multiqc** & investigate

    ```{bash}
    conda activate tools & multiqc .
    ```

5.  If good, `cp` **02_FASTQ_add_umi_loop.sh** & **02_FASTQ_add_umi.sh** into fastq-directory and run the former

6.  Make directory on Ygg scratch, and `cp` and edit **scrach_fastq_dir_to_samplesheet.sh** & **scratch**\_**fastq_dir_to_samplesheet.py** to this and run the former.

7.  `cp` and edit the **scratch_nextflow.sh** into same dir and run it

8.  Run multiqc

    ```{bash}
    conda activate tools & multiqc .
    ```

**Upon completion of analysis:**

1.  Make a copy of the SCOP_2022_XXXX working dir
2.  Sanitize it by removing all non-relevant files for the user. But it should still be able to run perfectly (except if missing raw-data in the case that it is large and stored in the outer data-raw folder).
3.  Append the date-of-hand-in to the folder-name
4.  Zip it
5.  Send via e-mail if possible, else via filesender
6.  Upload a local copy of the whole directory to the relevant project-dir with date of hand-in appended to it
7.  Move card on Trello #add this
