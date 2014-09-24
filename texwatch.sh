#!/bin/bash

# This script will monitor a .tex file and compile it when it is modified.
# Compilation is performed by pdflatex and the pdf rendered by evince.
# If an error occurs during compilation, the errors will be displayed in the
# console. Otherwise, a "Build ok" message will be displayed.
#
# Usage: texwatch.sh <myfile.tex>
#
# by Travis Mick, Sept 2014

infile=$1
outfile=${infile%.tex}.pdf
logfile=${infile%.tex}.log

mod_time() {
	T=`ls -l --time-style=+%s "$infile" | awk '{print $6}'`
	echo $T
}

build() {
	pdflatex -halt-on-error "$infile" 2>&1 >/dev/null
	if [ $? -ne  0 ]; then
		flag=0;
		while read line; do
			if [[ $flag == 1 ]]; then
				flag=0
				echo $line
			fi
			if [[ ${line:0:1} == "!" ]]; then
				flag=1
				echo $line
			fi
		done < "$logfile"
	else
		echo "Build ok."
	fi
	echo
}

prev_mod=`mod_time`

build
evince "$outfile" 2>&1 >/dev/null &

while true; do
	new_mod=`mod_time`
	if [ $new_mod -gt $prev_mod ]; then
		build
		prev_mod=$new_mod
		sleep 1
	fi
done
