#!/usr/bin/bashio
set +u

export DB_HOST=$(bashio::services "mysql" "host")
export APP_KEY=$(bashio::config 'APP_KEY')
export DB_CONNECTION="mysql"
export DB_PORT=$(bashio::services "mysql" "port")
export DB_USERNAME=$(bashio::services "mysql" "username")
export DB_PASSWORD=$(bbashio::services "mysql" "password")

export DB_DATABASE=$(\
    mysql \
        -u "${DB_USERNAME}" -p"${DB_PASSWORD}" \
        -h "${DB_HOST}" -P "${DB_PORT}" \
        --skip-column-names \
        -e "SHOW DATABASES LIKE 'firefly';"
)

if ! bashio::var.has_value "${DB_DATABASE}"; then
    bashio::log.info "Creating database for FireFly"
    mysql \
        -u "${DB_USERNAME}" -p"${DB_PASSWORD}" \
        -h "${DB_HOST}" -P "${DB_PORT}" \
            --execute="CREATE DATABASE IF NOT EXISTS 'firefly'"
fi


source /usr/local/bin/entrypoint.sh