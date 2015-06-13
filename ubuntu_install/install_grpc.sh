#!/bin/bash

set -e

if [[ -z ${GRPC_PREFIX_DIR} ]]; then
  echo "gRPC prefix directory unset. Please set them in install.sh"
  exit 1
fi

[[ -d ${GRPC_PREFIX_DIR} ]] || mkdir -p "${GRPC_PREFIX_DIR}"
