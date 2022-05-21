# RRBS analysis template using Biseq

A template for analyzing RRBS results using Bismark & BiSeq.

The main analysis itself is written in the form a .Rmd-file, which contains both code and interactive output for the user.

**Purpose and contents of directories in this repository:**

-   **data-raw:** This is where the raw transcript/gene counts are stored. Can be large files, which is not meant to be uploaded to the user, but only used for the analyses. Is by default ignored by git to prevent large files being uploaded.

-   **SCOP_2022_XXXX:** This is the local working directory where the actual analysis takes place. If more tissues/analyses are made, there will be several relevant sub-directories of this.

-   **SCOP_2022_XXXX/analysis.Rmd:** The template .Rmd-analysis, which contains basic analysis routine. When you knit the file, an .html-output with the corresponding name and today's date will be automatically generated, as well as a directory containing relevant outputs tied to the analysis.

-   **SCOP_2022_XXXX/data-raw:** Similar to the data directory another-level up, but is meant to be used if the raw data is manageable in size so that the full analysis can be run by the user.

-   **old_or_extra:** Mean to store stuff in if the working directory gets cluttered, but you don't want to delete stuff.

**Pre-processing steps before analysis:**

1.  On Yggdrasil/Nidhogg, Move 01_BCL/SampleSheet.csv into sequencing folder
2.  copy sequencing folder (name found in Trello) from seq-drive to SCOP-project dir (when mounted) as well as computerome
    -   mount: `mount_SCOP_share SCOP_2022_0XXX`
    -   CP to project dir `cp /data/SCOP/seq3/tqb695/XXXXXXXX /data/SCOP/SCOP_2022_0XXX/tqb695/RNAseq/01_BCL/`
    -   create folder on computerome `ssh thokoe@ssh.computerome.dk 'mkdir -p /home/projects/scratch/ku_00016/SCOP_2022_0XXX'`
    -   cp to computerome: `scp /data/SCOP/seq3/tqb695/XXXXXXXXX thokoe@ssh.computerome.dk:/home/projects/scratch/ku_00016/SCOP_2022_0XXX/`
3.  
4.  `cd` into sequencing folder and run `bcl2fastq.sh`
5.  `cd` into fastq-directory and run multiqc: `conda activate tools & multiqc .` & investigate
6.  Run `add_umi.sh` & `fastq_dir_to_samplesheet.sh`
7.  Edit the `nextflow.sh` pipeline and run it

**Upon completion of analysis:**

1.  Make a copy of the SCOP_2022_XXXX working dir
2.  Sanitize it by removing all non-relevant files for the user. But it should still be able to run perfectly (except if missing raw-data in the case that it is large and stored in the outer data-raw folder).
3.  Append the date-of-hand-in to the folder-name
4.  Zip it
5.  Send via e-mail if possible, else via filesender
6.  Upload a local copy of the whole directory to the relevant project-dir with date of hand-in appended to it
7.  Move card on Trello #add this
