FROM python:alpine

LABEL maintainer Alipeng <lipeng.yang@mobvista.com>

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data/
ENV EFB_PARAMS ""
ENV EFB_PROFILE "default"
ENV HTTPS_PROXY ""

RUN apk --update upgrade \
    && apk --update add tzdata ca-certificates \
       ffmpeg libmagic \
       tiff libwebp freetype lcms2 openjpeg py3-olefile openblas \
    && apk add --no-cache --virtual .build-deps build-base gcc python3-dev zlib-dev jpeg-dev libwebp-dev libffi-dev openssl-dev\
    && pip3 install numpy pillow pysocks ehforwarderbot efb-telegram-master efb-wechat-slave \
    && apk del .build-deps \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
