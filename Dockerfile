FROM ubuntu:20.04

ENV SWIFT_TAR_URL https://swift.org/builds/swift-5.3.1-release/ubuntu2004/swift-5.3.1-RELEASE/swift-5.3.1-RELEASE-ubuntu20.04.tar.gz

ENV WORK_DIR /
WORKDIR ${WORK_DIR}

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  clang \
  curl \
  dirmngr \
  git \
  gnupg2 \
  libbsd-dev \
  libcurl4-openssl-dev \
  libicu-dev \
  libsqlite3-dev \
  sqlite3 \
  libssl-dev \
  libxml2 \
  openssl \
  pkg-config \
  tzdata \
  xz-utils \
  zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN curl -fsSL $SWIFT_TAR_URL -o swift.tar.gz \
  && curl -fsSL $SWIFT_TAR_URL.sig -o swift.tar.gz.sig \
  && curl -fsSL https://swift.org/keys/all-keys.asc -o all-keys.asc \
  && gpg --import all-keys.asc \
  && rm all-keys.asc \
  && gpg --batch --verify swift.tar.gz.sig swift.tar.gz \
  && tar xzf swift.tar.gz --strip-components=1 \
  && rm swift.tar.gz \
  && rm swift.tar.gz.sig \
  && chmod -R go+r /usr/lib/swift \
  && rm -fr $GNUPGHOME \
  && swift --version

CMD /bin/bash
