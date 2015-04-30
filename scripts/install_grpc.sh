#!/bin/bash
#
# Installs gRPC the core in an existing Homebrew or Linuxbrew installation.
#
# prerequisites: Homebrew(Mac), Linuxbrew(Linux) is installed.
#
# Usage: $(curl -fsSL https://raw.githubusercontent.com/tbetbetbe/homebrew-grpc/scripts/install_grpc.sh) | bash -

__grpc_check_for_brew() {
    which 'brew' >> /dev/null || {
        if [ "$(uname)" == "Darwin" ]; then
            echo "Cannot find the brew command - please ensure you have installed Homebrew (http://brew.sh)";
        elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
            echo "Cannot find the brew command - please ensure you have installed Linuxbrew (https://github.com/Homebrew/linuxbrew#installation)";
        else
            echo "Your system is neither a Mac nor Linux, so gRPC is not currently supported";
        fi
        return 1;
    }
}

__grpc_install_with_brew() {
    # Explicitly install OpenSSL.
    if [ "$(uname)" != "Darwin" ]; then
        # there may be unresolved dependency issues installing openssl using linuxbrew on macs.
        brew install pkg-config
        brew install openssl
    else
        brew install openssl
    fi

    # Explicitly install protobuf.
    #
    # We need the alpha version of protobuf, that's currently packaged a devel package, and
    # for new we're installing the head version of gRPC
    # install it explicitly.
    brew install --devel protobuf

    # Install gRPC
    brew tap tbetbetbe/grpc
    brew install --HEAD grpc
}

main() {
    __grpc_check_for_brew || exit 1;
    __grpc_install_with_brew;
}

main
