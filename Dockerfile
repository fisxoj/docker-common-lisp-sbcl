FROM debian:jessie

MAINTAINER fisxoj@gmail.com

ENV DEBIAN_FRONTEND="noninteractive"

# Install Git

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
            build-essential \
            automake \
            libcurl4-openssl-dev \
            ca-certificates \
            git \
            && \
    apt-get -y autoremove --purge && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Roswell

RUN git clone -b release https://github.com/roswell/roswell.git && \
    cd roswell && \
    sh bootstrap && \
    ./configure && \
    make && \
    make install && \
    ros setup && \
    cd .. && \
    rm -rf roswell

# Install sbcl

RUN ros install sbcl-bin
