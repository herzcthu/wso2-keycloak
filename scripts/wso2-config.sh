#!/bin/sh

echo "checking if configuration file exist"
if [ -f /wso2conf/deployment.toml  ]; then
    echo "update deployment config"

    sleep 3

    toml set --toml-path /wso2conf/deployment.toml server.hostname $DOMAINNAME
    
    toml set --toml-path /wso2conf/deployment.toml database.apim_db.type postgre 
    toml set --toml-path /wso2conf/deployment.toml database.apim_db.url jdbc:postgresql://postgres:5432/wso2am_db
    toml set --toml-path /wso2conf/deployment.toml database.apim_db.username $APIDB_USER
    toml set --toml-path /wso2conf/deployment.toml database.apim_db.password $APIDB_PASSWORD
    toml set --toml-path /wso2conf/deployment.toml database.apim_db.driver org.postgresql.Driver
    toml set --toml-path /wso2conf/deployment.toml database.apim_db.validationQuery "SELECT 1"

    toml set --toml-path /wso2conf/deployment.toml database.shared_db.type postgre 
    toml set --toml-path /wso2conf/deployment.toml database.shared_db.url jdbc:postgresql://postgres:5432/wso2_shared_db
    toml set --toml-path /wso2conf/deployment.toml database.shared_db.username $APIDB_USER
    toml set --toml-path /wso2conf/deployment.toml database.shared_db.password $APIDB_PASSWORD
    toml set --toml-path /wso2conf/deployment.toml database.shared_db.driver org.postgresql.Driver
    toml set --toml-path /wso2conf/deployment.toml database.shared_db.validationQuery "SELECT 1"

    toml set --toml-path /wso2conf/deployment.toml apim.gateway.environment.0.service_url https://"$DOMAINNAME":'${mgt.transport.https.port}'/services/
    toml set --toml-path /wso2conf/deployment.toml apim.gateway.environment.0.ws_endpoint "ws://$DOMAINNAME:9099"
    toml set --toml-path /wso2conf/deployment.toml apim.gateway.environment.0.wss_endpoint "wss://$DOMAINNAME:8099"
    toml set --toml-path /wso2conf/deployment.toml apim.gateway.environment.0.http_endpoint http://"$DOMAINNAME":'${http.nio.port}'
    toml set --toml-path /wso2conf/deployment.toml apim.gateway.environment.0.https_endpoint https://"$DOMAINNAME":'${https.nio.port}'
    toml set --toml-path /wso2conf/deployment.toml apim.gateway.environment.0.websub_event_receiver_http_endpoint "http://$DOMAINNAME:9021"
    toml set --toml-path /wso2conf/deployment.toml apim.gateway.environment.0.websub_event_receiver_https_endpoint "https://$DOMAINNAME:8021"

    toml add_section --toml-path /wso2conf/deployment.toml apim.devportal

    toml set --toml-path /wso2conf/deployment.toml apim.devportal.url https://"$DOMAINNAME":'${mgt.transport.https.port}'/devportal

    toml set --toml-path /wso2conf/deployment.toml event_listener.0.properties.notification_endpoint https://"$DOMAINNAME":'${mgt.transport.https.port}'/internal/data/v1/notify

fi

exit 0