#!/bin/bash
set -ex

echo "HOME=$HOME"                         ## /home/travis
echo "TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR" ## $HOME/build/<user>/<repo>
pwd

tar czvf $TRAVIS_BUILD_DIR/release.tar.gz .travis.yml scripts/

