FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Alain Péteut

USER root

RUN apt-get update \
    && apt-get update \
    && apt-get install -yq --no-install-recommends git \
     cmake \
     build-essential \
     ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    &&  git clone https://github.com/ethereum-mining/ethminer.git --depth 1 \
    && cd ethminer \
    && mkdir build \
    && cd build \
    && cmake .. -DETHASHCUDA=ON -DETHASHCL=OFF -DETHSTRATUM=ON \
    && cmake --build . \
    && make install \
    && cd .. \
    && rm -rf ethminer \
    && rm -rf ~/.hunter/ 

ENTRYPOINT ["/usr/local/bin/ethminer", "-U"]
