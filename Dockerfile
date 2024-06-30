FROM --platform=linux/arm64 ubuntu:20.04

WORKDIR /build

ARG DEBIAN_FRONTEND=noninteractive
ARG BOOTSTRAP_HASKELL_GHC_VERSION=8.10.7
ARG BOOTSTRAP_HASKELL_NONINTERACTIVE=true
ARG BOOTSTRAP_HASKELL_DOWNLOADER=wget

RUN apt-get update

# Dependencies for building elm with GHC
RUN apt-get install -y \
    cmake \
    wget \
    libnuma-dev \
    zlib1g-dev \
    pkg-config \
    llvm-12*

# Dependencies for building GHC via: https://www.haskell.org/ghcup/install/#version-2004-2010
RUN apt-get install -y \
    build-essential \
    curl \
    libffi-dev \
    libffi7 \
    libgmp-dev \
    libgmp10 \
    libncurses-dev \
    libncurses5 \
    libtinfo5

RUN wget https://github.com/elm/compiler/archive/refs/tags/0.19.1.tar.gz && \
    tar -xvf 0.19.1.tar.gz && cd compiler-0.19.1

RUN rm /build/compiler-0.19.1/worker/elm.cabal

WORKDIR /build/compiler-0.19.1

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
RUN printf "jobs: $(nproc)" >> ./cabal.config

ENV PATH="/root/.ghcup/bin:$PATH"
ENV PATH="/root/.ghcup/env:$PATH"

RUN cabal new-update
RUN cabal new-configure
RUN cabal new-build

RUN strip -s ./dist-newstyle/build/aarch64-linux/ghc-8.10.7/elm-0.19.1/x/elm/build/elm/elm
RUN mv ./dist-newstyle/build/aarch64-linux/ghc-8.10.7/elm-0.19.1/x/elm/build/elm/elm /usr/local/bin/elm