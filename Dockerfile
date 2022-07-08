FROM ubuntu:22.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes software-properties-common

RUN add-apt-repository ppa:hardware-certification/public && \
    apt-get update

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends --assume-yes \
    rst2pdf \
    python3-pip \
    python3-venv \
    python3-sphinx \
    build-essential \
    plainbox-provider-resource-generic \
    plainbox-provider-certification-client \
    plainbox-provider-checkbox \
    canonical-certification-client \
    plainbox-provider-resource-generic \
    plainbox-provider-certification-server \
    plainbox-provider-checkbox \
    canonical-certification-server \
    canonical-certification-client \
    checkbox-ng

WORKDIR /docs

ENV VIRTUAL_ENV /opt/venv
RUN python3 -m venv /opt/venv
ENV PATH /opt/venv/bin:$PATH

COPY requirements.txt .
RUN /opt/venv/bin/pip install -r requirements.txt

