#!/bin/bash
version=$XLSX2CSV_VERSION
srcDIR=/data/upload/
tmpDIR=/data/tmp/
destDIR=/data/parsed/

if [ "-${version}-" == "-2-" ]; then
    poolDIR=/data/pool/
    /usr/bin/inotifywait -mrq --format '%f' -e create ${srcDIR} -e moved_to ${srcDIR} | while read file
    do
        tmp=${tmpDIR}${file}/
        mkdir -p ${tmp}
        echo "Start to convert: ${srcDIR}${file}"
        xlsx2csv -ae ${srcDIR}${file} ${tmp}
        if [ "$(ls -v ${tmp} 2> /dev/null)" == "" ]; then
            mv ${srcDIR}${file} ${poolDIR}${file}
            echo "Failed to convert: ${srcDIR}${file}"
        else 
            mv ${tmp} ${destDIR}
            rm ${srcDIR}${file}
            echo "Success: ${srcDIR}${file}"
        fi
    done
else
    /usr/bin/inotifywait -mrq --format '%f' -e create ${srcDIR} | while read file
    do
        tmp=${tmpDIR}${file}/
        mkdir -p ${tmp}
        echo "Start to convert: ${srcDIR}${file}"
        xlsx2csv -ae ${srcDIR}${file} ${tmp}
        if [ "$(ls -v ${tmp} 2> /dev/null)" == "" ]; then
            echo "Failed to convert: ${srcDIR}${file}"
        else 
            mv ${tmp} ${destDIR}
            echo "Success: ${srcDIR}${file}"
        fi
    done
fi
