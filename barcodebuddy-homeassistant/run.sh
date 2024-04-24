#!/usr/bin/with-contenv bashio
set -e

export ATTACH_BARCODESCANNER="$(bashio::config 'attach_barcodescanner')"
export DEVICE="$(bashio::config 'device')"
export IGNORE_SSL_CA="$(bashio::config 'curl_allow_insecure_ssl_ca')"
export IGNORE_SSL_HOST="$(bashio::config 'curl_allow_insecure_ssl_host')"

/app/supervisor