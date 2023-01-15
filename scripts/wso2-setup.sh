#!/bin/sh

echo "checking if truststore exist"
if [ ! -f /certs/client-truststore.jks  ]; then
    echo "copying truststore"
    cp /opt/wso2am/repository/resources/security/client-truststore.jks /certs/client-truststore.jks
fi

echo "checking if sql file exist"
if [ ! -f /dbscripts/postgresql.sql  ]; then
    echo "copying dbscripts"
    cp -r /opt/wso2am/dbscripts/* /dbscripts
fi

echo "checking if configuration file exist"
if [ ! -f /wso2conf/deployment.toml  ]; then
    echo "copying wso2 config file"
    cp /opt/wso2am/repository/conf/deployment.toml /wso2conf/deployment.toml
fi

exit 0
