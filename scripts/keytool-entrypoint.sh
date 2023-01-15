#!/bin/sh
echo "checking if keystore exist"
if [ ! -f /certs/server.keystore ]; then
    echo "generating keystore"
    keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias keycloak -ext "SAN:c=DNS:localhost,DNS:keycloak,DNS:api.domain.local,DNS:sso.domain.local,DNS:domain.local,IP:127.0.0.1" -keystore /certs/server.keystore
fi

echo "checking if truststore exist"
if [ ! -f /certs/keycloak.crt  ]; then
    echo "copying truststore"
    keytool -export -alias keycloak -file /certs/keycloak.crt -keystore /certs/server.keystore -storepass password -noprompt
    keytool -import -trustcacerts -alias keycloak -file /certs/keycloak.crt -keystore /certs/client-truststore.jks -storepass wso2carbon -noprompt
fi

exit 0