#!/usr/bin/env bash

declare -A IMAGE_OPTIONS
IMAGE_OPTIONS[alpine_version]="3.17"
IMAGE_OPTIONS[php_version]="81"
IMAGE_OPTIONS[deployer_version]="7.2"

help() {
    echo "Available options:"
    echo "  * i - alpine image version, e.g. 3.17"
    echo "  * p - php version given by the alpine image e.g. 81"
    echo "  * d - deployer version e.g. 7.2"
}

while getopts ":i:p:d:h" opt; do
  case $opt in
  h)
    help
    exit 1
    ;;
  i)
    IMAGE_OPTIONS[alpine_version]="${OPTARG}"
    ;;
  p)
    IMAGE_OPTIONS[php_version]="${OPTARG}"
    ;;
  d)
    IMAGE_OPTIONS[deployer_version]="${OPTARG}"
    ;;
  *)
    echo "Invalid option: -$OPTARG"
    help
    exit 1
    ;;
  esac
done

echo "Image information:"
build_args=""
for i in "${!IMAGE_OPTIONS[@]}"
do
  echo "  ${i}: ${IMAGE_OPTIONS[$i]}"
  build_args+="--build-arg ${i}=\"${IMAGE_OPTIONS[$i]}\" "
done

docker build --progress plain --no-cache --pull . -f Dockerfile -t "ochorocho/deployer:${IMAGE_OPTIONS[deployer_version]}" && \
docker run --rm -it -v "$(pwd)/test.sh:/tmp/test.sh" --entrypoint "ash" "ochorocho/deployer:${IMAGE_OPTIONS[deployer_version]}" /tmp/test.sh
