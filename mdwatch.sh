#!/bin/bash

infile=$1
outfile=${1%.*}.html

build() {
    pandoc $infile -o $outfile
}

[[ `ls -t ${infile} ${outfile} 2>/dev/null | wc -l` -eq 1 ]] && `build`
[[ `ls -t ${infile} ${outfile} 2>/dev/null | wc -l` -eq 2 ]] || echo -e "No inputfile!\n\nUsage:\n\t${0} <input.md>\n"

while true; do
    [[ `ls -t ${infile} ${outfile} 2>/dev/null | head -n1` == ${infile} ]] && `build` || clear; date +"%Y-%m-%d %H:%M:%S"
    sleep 1
done
