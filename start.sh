#!/bin/sh

srcDIR=/data/upload/
tmpDIR=/data/tmp/
destDIR=/data/parsed/

if [ ! -d $srcDIR ]; then
    mkdir -p $srcDIR
fi

if [ ! -d $tmpDIR ]; then
    mkdir -p $tmpDIR
fi

if [ ! -d $destDIR ]; then
    mkdir -p $destDIR
fi

/usr/bin/inotifywait -mrq --format '%f' -e create ${srcDIR} | while read file
do
    tmp=${tmpDIR}${file%%.*}/
	mkdir -p ${tmp}
    echo "Start to convert: ${srcDIR}${file}"
	xlsx2csv -a -i ${srcDIR}${file} ${tmp}
    if [ "$(ls -v ${tmp} 2> /dev/null)" == "" ]; then
        echo "Failed to convert: ${srcDIR}${file}"
    else 
        mv ${tmp} ${destDIR}
        echo "Success: ${srcDIR}${file}"
    fi
done
