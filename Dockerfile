FROM alpine:3.2

RUN apk update && \
    apk add inotify-tools py-pip && \
    rm -rf /var/cache/apk/* && \
    pip install xlsx2csv

ADD start.sh /start.sh

CMD ["/start.sh"]
