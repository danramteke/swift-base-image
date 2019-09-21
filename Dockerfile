FROM ubuntu:18.04

ENV SWIFT_TAR_URL https://swift.org/builds/swift-5.1-release/ubuntu1804/swift-5.1-RELEASE/swift-5.1-RELEASE-ubuntu18.04.tar.gz

ENV WORK_DIR /
WORKDIR ${WORK_DIR}

RUN apt-get update && apt-get dist-upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  clang \
  curl \
  dirmngr \
  git \
  gnupg2 \
  libbsd-dev \
  libcurl4-openssl-dev \
  libicu-dev \
  libpython2.7 \
  libsqlite3-dev \
  sqlite3 \
  libssl-dev \
  libxml2 \
  openssl \
  pkg-config \
  tzdata \
  vim \
  xz-utils \
  zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN curl -fsSL $SWIFT_TAR_URL -o swift.tar.gz \
  && curl -fsSL $SWIFT_TAR_URL.sig -o swift.tar.gz.sig \
  && export GNUPGHOME="$(mktemp -d)" \
  && echo "disable-ipv6" > $GNUPGHOME/dirmgngr.conf \
  && gpg --keyserver hkp://pool.sks-keyservers.net  \
  --recv-keys \
  '8513 444E 2DA3 6B7C 1659  AF4D 7638 F1FB 2B2B 08C4' \
  'A62A E125 BBBF BB96 A6E0  42EC 925C C1CC ED3D 1561' \
  && gpg --keyserver hkp://pool.sks-keyservers.net  --refresh-keys  \
  && gpg --batch --verify swift.tar.gz.sig swift.tar.gz \
  && tar xzf swift.tar.gz --strip-components=1 \
  && rm swift.tar.gz \
  && rm swift.tar.gz.sig \
  && chmod -R go+r /usr/lib/swift \
  && rm -fr $GNUPGHOME \
  && swift --version

CMD /bin/bash
