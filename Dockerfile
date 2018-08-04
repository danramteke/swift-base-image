FROM ibmcom/swift-ubuntu-xenial:latest as builder

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y \
  pkg-config \
  build-essential \
  clang-3.8 \
  dirmngr \
  git \
  gnupg2 \
  libbsd-dev \
  libcurl4-openssl-dev \
  libicu-dev \
  libpython2.7 \
  libpq-dev \
  libsqlite3-dev \
  libxml2 \
  wget \
  vim \
  zlib1g-dev \
  tzdata \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 