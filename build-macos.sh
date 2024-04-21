#!/bin/bash

set -euo pipefail

CONFIG="${1?}"
VERSION="${2?}"
CURL_DIR="${3?}"

cmake "$CURL_DIR" -B "build_$CONFIG" \
  -DCMAKE_BUILD_TYPE="$CONFIG" \
  -DCURL_USE_OPENSSL=OFF \
  -DCURL_USE_SECTRANSP=ON \
  -DBUILD_CURL_EXE=OFF \
  -DBUILD_SHARED_LIBS=OFF \
  -DHTTP_ONLY=ON \
  -DCURL_USE_LIBSSH2=OFF \
  -DBUILD_TESTING=OFF \
  -DPICKY_COMPILER=OFF

cmake --build "build_$CONFIG"
cmake --install "build_$CONFIG" --prefix "release/$CONFIG"
tar -C "release/$CONFIG" -cvf "release/curl-macos-$VERSION-$CONFIG.tar.gz" .
