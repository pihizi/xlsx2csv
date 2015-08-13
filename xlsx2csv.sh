#!/bin/sh
srcDIR=/data/upload/
tmpDIR=/data/tmp/
destDIR=/data/parsed/
/usr/bin/inotifywait -mrq --format '%f' -e create ${srcDIR} | while read file
do
    tmp=${tmpDIR}${file%%.*}/
	mkdir -p ${tmp}
	xlsx2csv -a -i ${srcDIR}${file} ${tmp}
    mv ${tmp} ${destDIR}
done
