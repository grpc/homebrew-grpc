#!/bin/bash

set -e

TAR_FILE="v3.0.0-alpha-3.tar.gz"
TAR_URI="https://github.com/google/protobuf/archive/v3.0.0-alpha-3.tar.gz"
TAR_HASH="bf90fb01b054d364d05d362d63e09d3466311e24bd6db1127dfcd88af443bf05"
TARRED_DIR="protobuf-3.0.0-alpha-3"

if [[ -z ${PROTOBUF_PREFIX_DIR} ]]; then
  echo "Protobuf prefix directory unset. Please set in install.sh"
  exit 1
fi

[[ -d ${PROTOBUF_PREFIX_DIR} ]] || mkdir -p "${PROTOBUF_PREFIX_DIR}"

########################
# Check prerequisites. #
########################
# H/T: http://askubuntu.com/a/140574
# NOTE: Assumes make and other utils were checked by install_openssl.sh.
PACKAGES="m4 automake autoconf unzip libtool"
for PACKAGE in ${PACKAGES}; do
    dpkg -s ${PACKAGE} >/dev/null 2>&1 || {
        echo "${PACKAGE} is not installed. Please install it via:"
        echo "    [sudo] apt-get update"
        echo "    [sudo] apt-get install ${PACKAGE}"
        exit 1
    }
done

###################################
# Prepare the source for install. #
###################################
cd ${SANDBOX_DIR}  # Assume SANDBOX_DIR is set by the caller.
if [[ -f ${TAR_FILE} ]]; then
  echo "${TAR_FILE} exists."
else
  curl -o ${TAR_FILE} -fSL ${TAR_URI}
fi

echo "Verifying ${TAR_FILE} checksum."
if [[ $(sha256sum ${TAR_FILE} | cut -f 1 -d' ') != ${TAR_HASH} ]]; then
  echo "${TAR_FILE} checksum is incorrect. Removing file and exiting."
  rm -f ${TAR_FILE}
  exit 1
fi

if [[ -d ${TARRED_DIR} ]]; then
  echo "${TARRED_DIR} directory already exists. Removing."
  rm -fr ${TARRED_DIR}
fi
tar -zxf ${TAR_FILE}

echo "Entering ${TARRED_DIR}."
cd ${TARRED_DIR}

##############################
# Begin install from source. #
##############################
./autogen.sh
./configure --disable-debug --disable-dependency-tracking \
--prefix=${PROTOBUF_PREFIX_DIR} --with-zlib
make
make install
