#!/bin/bash

set -e

export OPENSSL_PREFIX_DIR="${HOME}/Desktop/sandbox/openssl_prefix"
export OPENSSL_ETC_DIR="${OPENSSL_PREFIX_DIR}/etc"
export PROTOBUF_PREFIX_DIR="${HOME}/Desktop/sandbox/protobuf_prefix"
export GRPC_PREFIX_DIR="${HOME}/Desktop/sandbox/grpc_prefix"

###################################
# Create temporary work directory #
###################################
export SANDBOX_DIR=$(mktemp -d)

###################################
# Install each dependent package. #
# NOTE: Order is important.       #
###################################
./install_openssl.sh
./install_protobuf.sh
./install_grpc.sh
./install_grpc_python.sh
