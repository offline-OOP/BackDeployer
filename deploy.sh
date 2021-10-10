#!/bin/bash
source helpers.sh

docker swarm init

create_secret "neo4j_password" "$NEO4J_PASSWORD"
create_secret "redis_password" "$REDIS_PASSWORD"
create_secret "mail_password" "$MAIL_PASSWORD"
create_secret "jwt_key" "$JWT_KEY"

if [[ $(docker network ls | grep "app") = "" ]]; then
    log "${GREEN} Creating app network ${CLOSE}"
    docker network create --opt encrypted -d overlay --attachable app
else
    log "${YELLOW} Network app already exists ${CLOSE}"
fi

log "${GREEN} Logging to docker repo ${CLOSE}"
docker login -u "$CI_REPOSITORY_NAME" -p "$CI_REPOSITORY_PASSWORD"

log "${GREEN} Deploying app ${CLOSE}"
NEO4J_PASSWORD=$NEO4J_PASSWORD REDIS_PASSWORD=$REDIS_PASSWORD docker stack deploy -c stack/db/stack.yml app-db-stack
docker stack deploy -c stack/app/stack.yml app-stack