#!/bin/bash

if [[ $# -lt 3 ]]; then
    echo "Usage: $0 R1_file UMI_file compress_cores"
    exit 1
fi

trap 'rm -rf "$fifo_dir"' EXIT

fifo_dir=$(mktemp -p "/tmp/" -d dir-XXXX) || exit 1

mkfifo -m 600 "$fifo_dir/f1"

/home/cbmr/tqb695/projects_tqb695/tools/pigz-2.7/pigz -p 1 -c -d $1 > $fifo_dir/f1 &

/home/cbmr/tqb695/projects_tqb695/tools/pigz-2.7/pigz -p 1 -c -d $2 | /home/cbmr/tqb695/projects_tqb695/tools/mawk-1.3.4-20200120/mawk -vinfile="$fifo_dir/f1" '{
if (NR % 4 == 2)
{
    getline header < infile
    print header

    getline seq < infile
    print $0 seq

    getline plus < infile
    print plus
}
else if (NR % 4 == 0)
{
    getline qual < infile
    print $0 qual
}
}' | /home/cbmr/tqb695/projects_tqb695/tools/pigz-2.7/pigz -p $3 -c > ${1/.fastq.gz/_umi.fastq.gz}

rm -rf "$fifo_dir"