#!/bin/bash

set -e

if [[ -z ${PROTOBUF_PREFIX_DIR} ]]; then
  echo "Protobuf prefix directory unset. Please set them in install.sh"
  exit 1
fi

[[ -d ${PROTOBUF_PREFIX_DIR} ]] || mkdir -p "${PROTOBUF_PREFIX_DIR}"
