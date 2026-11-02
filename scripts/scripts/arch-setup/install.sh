#!/usr/bin/env bash

set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
MODULES_DIR=$ROOT/modules
PROFILES_DIR=$ROOT/profiles
BUILD_DIR=${BUILD_DIR:-$HOME/src}
STAMP_DIR=$BUILD_DIR/.stamps

DRY_RUN=0 LIST_ONLY=0 PROFILE="" MODULE_ARG=""
WITH=() WITHOUT=()

for f in common pkg runner; do
	source "$ROOT/lib/$f.sh"
done
