ARG BUILD_FROM=fireflyiii/core:latest
FROM $BUILD_FROM


ARG TZ=Europe/Amsterdam
ARG BUILD_ARCH="amd64"
ARG BASHIO_VERSION="0.16.2"
ARG TEMPIO_VERSION="2021.09.0"


RUN \
    set -x \
    && apt-get update && apt-get install -y --no-install-recommends \
        mariadb-client \
        bash \
        jq \
        tzdata \
        curl \
        ca-certificates \
        xz-utils \
    && curl -L -f -s -o /usr/bin/tempio \
        "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/tempio \
    \
    && mkdir -p /usr/src/bashio \
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
        | tar -xzf - --strip 1 -C /usr/src/bashio \
    && mv /usr/src/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/src/*

COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]