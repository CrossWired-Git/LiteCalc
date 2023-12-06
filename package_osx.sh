#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

if ! command -v 'source' &> /dev/null
then
    echo "source is required to execute the build scripts."
    exit 1
fi

SOURCE_DIR="$DIR/src"
BUILD_DIR="$DIR/build"

echo "Building for OSX x64."
echo "Script is running please wait..."
source "$DIR/package_osx_x64.sh" $BUILD_DIR $SOURCE_DIR