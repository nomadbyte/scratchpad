#!/bin/bash
set -ex

echo "HOME=$HOME"                         ## /home/travis
echo "TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR" ## $HOME/build/<user>/<repo>
pwd

wget https://github.com/rjperrella/jenkins-fossil-adapter/archive/master.tar.gz --output-document source.tar.gz
mkdir source && tar xvf source.tar.gz --strip-components=1 -C source
rm -rf source.tar.gz
cd source

cd fossil
mvn clean verify

ls -al $TRAVIS_BUILD_DIR/source/fossil/target

cd $TRAVIS_BUILD_DIR/source/fossil/target
tar czvf $TRAVIS_BUILD_DIR/release.tar.gz fossil.jar fossil.hpi

