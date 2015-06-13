#!/bin/bash

set -e

if [[ -z ${OPENSSL_PREFIX_DIR} ]] || \
       [[ -z ${PROTOBUF_PREFIX_DIR} ]] || \
       [[ -z ${GRPC_PREFIX_DIR} ]]; then
  echo "One of prefix directories unset. Please set them in install.sh"
  exit 1
fi

CFLAGS="-I${OPENSSL_PREFIX_DIR}/include -I${PROTOBUF_PREFIX_DIR}/include -I${GRPC_PREFIX_DIR}/include" \
CPPFLAGS="-I${OPENSSL_PREFIX_DIR}/include -I${PROTOBUF_PREFIX_DIR}/include -I${GRPC_PREFIX_DIR}/include" \
LDFLAGS="-L${OPENSSL_PREFIX_DIR}/lib -L${PROTOBUF_PREFIX_DIR}/lib -L${GRPC_PREFIX_DIR}/lib" \
pip install grpcio
