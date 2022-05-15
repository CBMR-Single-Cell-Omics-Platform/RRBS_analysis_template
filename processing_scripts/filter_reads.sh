#!/bin/bash

if [[ $# -lt 3 ]]; then
    echo "Usage: $0 R1_file R2_file compress_cores"
    exit 1
fi

trap 'rm -rf "$fifo_dir"' EXIT

fifo_dir=$(mktemp -p "/tmp/" -d dir-XXXX) || exit 1
mkfifo -m 600 "$fifo_dir/r2" "$fifo_dir/r1_out" "$fifo_dir/r2_out"

pigz -p 1 -c -d $2 > $fifo_dir/r2 &

pigz -p 1 -c -d $1 | mawk -vif2="$fifo_dir/r2" -vof1="$fifo_dir/r1_out" -vof2="$fifo_dir/r2_out" '
{
    getline seq_r1
    getline plus_r1
    getline qual_r1

    getline header_r2 < if2
    getline seq_r2 < if2
    getline plus_r2 < if2
    getline qual_r2 < if2

    if (length(seq_r1) > 8) {
        print $0 > of1
        print seq_r1 > of1
        print plus_r1 > of1
        print qual_r1 > of1

        print header_r2 > of2
        print seq_r2 > of2
        print plus_r2 > of2
        print qual_r2 > of2
    }
}' &

pigz -p $3 -c $fifo_dir/r1_out > ${1/.fastq.gz/.filtered.fastq.gz} &
pigz -p $3 -c $fifo_dir/r2_out > ${2/.fastq.gz/.filtered.fastq.gz}

rm -rf "$fifo_dir"

