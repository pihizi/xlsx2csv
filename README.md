## Example

        docker run --name xlsx2csv --privileged \
            --restart=always \
            -v /dev/log:/dev/log \
            -v /data/upload:/data/upload \
            -v /data/parsed:/data/parsed\
            -d pihizi/xlsx2csv
