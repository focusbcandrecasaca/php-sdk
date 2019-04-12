#!/bin/bash

set -euo pipefail

version=$(sh pipeline/scripts/00-get-next-version.sh $1)
php_version=${2:-5.6}

script_dir=$(dirname "$(pwd)/$0")

pushd "$script_dir" > /dev/null

cd ../..

echo "Building PHP5.6 image for version $version"
PHP_VERSION=5.6 docker build . -f Dockerfile -t "mapify-sdk-test:5.6.$version"
echo "Building PHP7 image for version $version"
PHP_VERSION=7 docker build . -f Dockerfile -t "mapify-sdk-test:7.$version"

popd > /dev/null
