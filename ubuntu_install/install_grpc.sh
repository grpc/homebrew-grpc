#!/bin/bash

set -e

TAR_FILE="release-0_9_0.tar.gz"
TAR_URI="https://github.com/grpc/grpc/archive/release-0_9_0.tar.gz"
TAR_HASH="c7cd980f3408fbf70e249bdc894fdf379d730c7b165ed1fe796954a0eb560a3b"
TARRED_DIR="grpc-release-0_9_0"

if [[ -z ${GRPC_PREFIX_DIR} ]] || \
       [[ -z ${OPENSSL_PREFIX_DIR} ]] || \
       [[ -z ${PROTOBUF_PREFIX_DIR} ]]; then
  echo "gRPC, OpenSSL and protobuf prefix directories unset."
  echo "Please set in install.sh."
  exit 1
fi

[[ -d ${GRPC_PREFIX_DIR} ]] || mkdir -p "${GRPC_PREFIX_DIR}"

# NOTE: Assumes prerequisites were checked by
#       install_openssl.sh and install_protobuf.sh

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

#######################################################
# Begin install from source.                          #
#                                                     #
# NOTE: Verifying the install requires protoc on PATH #
#######################################################
PATH="${PATH}:${PROTOBUF_PREFIX_DIR}/bin" \
CFLAGS="-I${OPENSSL_PREFIX_DIR}/include -I${PROTOBUF_PREFIX_DIR}/include" \
CPPFLAGS="-I${OPENSSL_PREFIX_DIR}/include -I${PROTOBUF_PREFIX_DIR}/include" \
LDFLAGS="-L${OPENSSL_PREFIX_DIR}/lib -L${PROTOBUF_PREFIX_DIR}/lib" \
make install install_grpc_csharp_ext prefix=${GRPC_PREFIX_DIR}
