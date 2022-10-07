#!/home/people/lroin/group_folder/apps/miniconda3/bin/python
import sys
import gzip
import glob
from Bio import SeqIO

fqFile = sys.argv[1]
idxFile = fqFile.replace("R1_001.fastq.gz", "R2_001.fastq.gz")
    
with gzip.open(fqFile, "rt") as inFile:
    with gzip.open(idxFile, "rt") as idxFile:
        idxIterator = SeqIO.parse(idxFile, "fastq")
        with gzip.open(fqFile.replace(".fastq.gz", ".UMI.fastq.gz"), 'wb') as outFile:
            for record in SeqIO.parse(inFile, "fastq"):
                idx = next(idxIterator)
                record.description = record.description + ":" + str(idx.seq)
                outFile.write(record.format("fastq").encode("ascii"))


