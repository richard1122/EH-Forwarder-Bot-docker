FROM alpine:latest

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data

RUN apk upgrade --update \
 && apk add --update tzdata ca-certificates ffmpeg libmagic python3 tiff libwebp freetype lcms2 openjpeg py3-olefile openblas \
 && apk add --no-cache --virtual .build-deps build-base gcc python3-dev zlib-dev jpeg-dev libwebp-dev git \
 && pip3 install --upgrade pip \
 && pip3 install numpy pillow pysocks \
 && pip3 install git+https://github.com/blueset/ehforwarderbot.git \
 && pip3 install git+https://github.com/blueset/efb-telegram-master.git \
 && pip3 install git+https://github.com/richard1122/efb-wechat-slave \
 && apk del .build-deps \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo "Asia/Shanghai" > /etc/timezone

VOLUME [ "/data" ]
ENTRYPOINT ["ehforwarderbot"]
