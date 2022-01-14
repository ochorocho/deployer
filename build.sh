#!/bin/bash

docker build --progress plain --no-cache --pull . -f Dockerfile -t ochorocho/deployer:latest && docker run --rm -it -v `pwd`/test.sh:/tmp/test.sh --entrypoint "ash" ochorocho/deployer:latest /tmp/test.sh
docker images | grep docker-deployer
