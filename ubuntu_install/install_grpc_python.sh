#!/bin/bash

set -e

if [[ -z ${OPENSSL_PREFIX_DIR} ]] || \
       [[ -z ${OPENSSL_ETC_DIR} ]] || \
       [[ -z ${PROTOBUF_PREFIX_DIR} ]] || \
       [[ -z ${GRPC_PREFIX_DIR} ]]; then
  echo "One of prefix directories unset. Please set them in install.sh"
  exit 1
fi
