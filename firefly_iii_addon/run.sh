#!/usr/bin/bashio
set +u

export DB_HOST="$(bashio::config 'DB_HOST')")
export APP_KEY="$(bashio::config 'APP_KEY')")
export DB_CONNECTION="$(bashio::config 'DB_CONNECTION')")
export DB_PORT="$(bashio::config 'DB_PORT')")
export DB_DATABASE="$(bashio::config 'DB_DATABASE')")
export DB_USERNAME="$(bashio::config 'DB_USERNAME')")
export DB_PASSWORD="$(bashio::config 'DB_PASSWORD')")


source /usr/local/bin/entrypoint.sh