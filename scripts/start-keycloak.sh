#!/bin/sh
# wait-for-postgres.sh

set -e
sleep $1
shift
/opt/keycloak/bin/kc.sh build --db $KC_DB
/opt/keycloak/bin/kc.sh start --optimized "$@"