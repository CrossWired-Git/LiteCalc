#!/usr/bin/env bash

#Get the script's directory.
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

OS=osx
ARCH="$1"
BUILD_DIR="$DIR/build"
SOURCE_DIR="$DIR/src"
CACHE_DIR="$BUILD_DIR/$OS/cache/$ARCH"
nw_version=0.82.0

if ! command -v 'wget' &> /dev/null
then
    echo "wget is required to download the nw binaries."
    exit 1
fi

if ! command -v 'unzip' &> /dev/null
then
    echo "unzip is required to extract the nw binaries."
    exit 1
fi

if ! command -v 'cp' &> /dev/null
then
    echo "cp is required to copy the data to the binary."
    exit 1
fi

if ! command -v 'mv' &> /dev/null
then
    echo "mv is required to rename and move the app."
    exit 1
fi

if [ "$ARCH" == "" ]; then
  ARCH=x64
fi



#Downloading and extracting the binary
[ ! -d "$CACHE_DIR" ] && mkdir -p "$CACHE_DIR"
wget -q -P "$CACHE_DIR" "https://dl.nwjs.io/v$nw_version/nwjs-v$nw_version-osx-$ARCH.zip" 
unzip -qq -o "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH.zip" -d "$CACHE_DIR"
rm -r "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH.zip"

mkdir -p "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app/Contents/Resources/app.nw"
cp -R "$SOURCE_DIR"/* "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app/Contents/Resources/app.nw"

#Setting the icons
[ -f "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app/Contents/Resources/app.icns" ] && rm -r "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app/Contents/Resources/app.icns"
[ -f "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app/Contents/Resources/document.icns" ] && rm -r "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app/Contents/Resources/document.icns"

cp "$DIR/ext/osx/icon.icns" "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app/Contents/Resources/app.icns"
cp "$DIR/ext/osx/icon.icns" "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app/Contents/Resources/document.icns"

#Ready to go
mv "$CACHE_DIR/nwjs-v$nw_version-osx-$ARCH/nwjs.app" "$BUILD_DIR"
mv "$BUILD_DIR/nwjs.app" "$BUILD_DIR/LiteCalc.app"

#Clean up
[ -d "$CACHE_DIR" ] && rm -r "$CACHE_DIR"
