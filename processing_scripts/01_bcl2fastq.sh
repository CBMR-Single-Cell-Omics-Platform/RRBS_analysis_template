bcl2fastq -R . \
-o ../../02_FASTQ/  \
-r 10 -w 10 -p 20 \
--no-lane-splitting \
--use-bases-mask Y*,I8Y8,I8,Y* \
--mask-short-adapter-reads 0 \
--minimum-trimmed-read-length 8