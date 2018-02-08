#!/bin/bash -ex

echo "HOME=$HOME"                         ## /home/travis
echo "TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR" ## $HOME/build/<user>/<repo>
pwd

## get sources
mkdir sources
cd sources

rm -f sources.tar.gz

wget -O sources.tar.gz https://github.com/nomadbyte/fredcpp/archive/master.tar.gz
tar xvf sources.tar.gz
if [ ! -d fredcpp-master ]
then
  echo "E|NOSOURCES - fredcpp source directory not found." >&2
  exit 1
fi

cd fredcpp-master

## setup env

if [ ! -s api.key ] ; then echo "$FRED_API_KEY" > api.key ; fi

if [ ! -s api.key ]
then
  echo "E|NOAPIKEY - 'api.key' file is missing or empty." >&2
  exit 1
fi


## CURL CA root certificates
##   curl-config --ca  OR curl -v --cacert no-such-file https://google.com
CURL_CA_CERT=/etc/ssl/certs/ca-certificates.crt
[ -s cacert.pem ] || cp  "$CURL_CA_CERT" cacert.pem

if [ ! -s cacert.pem ]
then
  echo "E|NOCACERTS - 'cacert.pem' file is missing or empty." >&2
  exit 1
fi


[ ! -d build ] && mkdir build
cd build

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo ..

## build

make clean all
make test ARGS="-V -E acceptanceTests"
#make test ARGS="-V -R acceptanceTests"

#ctest -V

