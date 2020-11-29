FROM debian:bullseye-slim

ENV INITRD=no \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apt-transport-https git dirmngr

RUN gpg --keyserver pool.sks-keyservers.net --recv-key F8E3347256922A8AE767605B7808CE96D38B9201 && \
    gpg --export '7808CE96D38B9201' | apt-key add - && \
    echo "deb https://www.lesbonscomptes.com/recoll/debian/ bullseye main" >> /etc/apt/sources.list.d/recoll.list && \
    echo "deb-src https://www.lesbonscomptes.com/recoll/debian/ bullseye main" >> /etc/apt/sources.list.d/recoll.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends recollcmd python3-recoll gunicorn python3-ujson \
                                               aspell-en unzip xsltproc unrtf untex libimage-exiftool-perl antiword tesseract-ocr poppler-utils wv && \
    apt-get autoremove && apt-get clean

# should be https://github.com/Yetangitu/recoll-webui/tree/jsonpage but it is written in Python 2
RUN mkdir /data && \
    mkdir -p /root/.recoll && \
    git clone https://framagit.org/medoc92/recollwebui.git recollwebui

ADD start.sh gunicorn.conf /root/
ADD recoll.conf /root/.recoll/
CMD '/root/start.sh'

EXPOSE 8080

VOLUME /data
