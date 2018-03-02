FROM debian:jessie
MAINTAINER Digitransit version: 0.1
ARG DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y \
  siege \
  curl \
  jq
RUN rm -rf /var/lib/apt/lists/*
COPY scripts /usr/src/app/scripts
COPY test_files /usr/src/app/test_files
CMD ["/bin/bash", "-x", "scripts/run-tests.sh"]