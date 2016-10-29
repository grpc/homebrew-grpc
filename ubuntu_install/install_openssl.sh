#!/bin/bash

set -e

# "$(uname -s)-$(arch)"
OPENSSL_ARCH="linux-x86_64"
TAR_FILE="openssl-1.0.2a.tar.gz"
TAR_URI="https://raw.githubusercontent.com/DomT4/LibreMirror/master/OpenSSL/openssl-1.0.2a.tar.gz"
TAR_HASH="15b6393c20030aab02c8e2fe0243cb1d1d18062f6c095d67bca91871dc7f324a"
TARRED_DIR="openssl-1.0.2a"
PATCH1_FILE="6281abc796234.diff"
PATCH1_URI="https://github.com/openssl/openssl/commit/6281abc796234.diff"
PATCH1_HASH="f8b94201ac2cd7dcdee3b07fb3cd77a2de6b81ea67da9ae075cf06fb0ba73cea"
PATCH2_FILE="dfd3322d72a2.diff""6281abc796234.diff"
PATCH2_URI="https://github.com/openssl/openssl/commit/dfd3322d72a2.diff"
PATCH2_HASH="0602eef6e38368c7b34994deb9b49be1a54037de5e8b814748d55882bfba4eac"

if [[ -z ${OPENSSL_PREFIX_DIR} ]] || \
       [[ -z ${OPENSSL_ETC_DIR} ]]; then
  echo "OpenSSL directories unset. Please set them in install.sh"
  exit 1
fi

[[ -d ${OPENSSL_PREFIX_DIR} ]] || mkdir -p ${OPENSSL_PREFIX_DIR}
[[ -d ${OPENSSL_ETC_DIR} ]] || mkdir -p ${OPENSSL_ETC_DIR}

########################
# Check prerequisites. #
########################
# H/T: http://askubuntu.com/a/140574
PACKAGES="make xutils-dev patch gcc build-essential pkg-config"
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

if [[ -f ${PATCH1_FILE} ]]; then
  echo "${PATCH1_FILE} exists."
else
  curl -o ${PATCH1_FILE} -fSL ${PATCH1_URI}
fi

if [[ -f ${PATCH2_FILE} ]]; then
  echo "${PATCH2_FILE} exists."
else
  curl -o ${PATCH2_FILE} -fSL ${PATCH2_URI}
fi

echo "Verifying ${PATCH1_FILE} checksum."
if [[ $(sha256sum ${PATCH1_FILE} | cut -f 1 -d' ') != ${PATCH1_HASH} ]]; then
  echo "${PATCH1_FILE} checksum is incorrect. Removing file and exiting."
  rm -f ${PATCH1_FILE}
  exit 1
fi

echo "Verifying ${PATCH2_FILE} checksum."
if [[ $(sha256sum ${PATCH2_FILE} | cut -f 1 -d' ') != ${PATCH2_HASH} ]]; then
  echo "${PATCH2_FILE} checksum is incorrect. Removing file and exiting."
  rm -f ${PATCH2_FILE}
  exit 1
fi

echo "Entering ${TARRED_DIR} and applying patches."
cd ${TARRED_DIR}
patch -p1 < "../${PATCH1_FILE}"
patch -p1 < "../${PATCH2_FILE}"

##############################
# Begin install from source. #
##############################
perl ./Configure --prefix=${OPENSSL_PREFIX_DIR} \
--openssldir=${OPENSSL_ETC_DIR} \
no-ssl2 zlib-dynamic shared enable-cms \
${OPENSSL_ARCH}

make depend
make
make test
make install MANDIR="${OPENSSL_PREFIX_DIR}/share/man" MANSUFFIX=ssl
