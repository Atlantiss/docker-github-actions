#!/bin/sh

if [ -z "$BOOST_VERSION" ]; then
    echo ERROR: BOOST_VERSION is not defined
    exit 1
fi

BOOST_FILE_NAME=`echo "$BOOST_VERSION" | sed 's/\./_/g'`

curl -SL https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_FILE_NAME}.tar.gz | tar -zx 
cd boost_${BOOST_FILE_NAME}
./bootstrap.sh --with-libraries=all --with-toolset=clang
./b2 install -j 8
cd ..
rm -rf boost_${BOOST_FILE_NAME}

echo "Boost ($BOOST_VERSION) installed."
