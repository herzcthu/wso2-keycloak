#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER $APIDB_USER WITH PASSWORD '$APIDB_PASSWORD';
    CREATE DATABASE WSO2_SHARED_DB;
    CREATE DATABASE WSO2AM_DB;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d wso2_shared_db -f /dbscripts/postgresql.sql -W

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d wso2am_db -f /dbscripts/apimgt/postgresql.sql  -W

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d wso2_shared_db <<-EOSQL
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $APIDB_USER;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $APIDB_USER;

EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d wso2am_db <<-EOSQL
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $APIDB_USER;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $APIDB_USER;
EOSQL