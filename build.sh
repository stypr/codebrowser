#!/bin/sh

# Build again
make clean
make

OUTPUT_DIRECTORY=/var/www/html/p/
DATA_DIRECTORY=$OUTPUT_DIRECTORY/../
rm -rf $OUTPUT_DIRECTORY $DATA_DIRECTORY

BUILD_DIRECTORY=$PWD
SOURCE_DIRECTORY=$PWD
VERSION=`git describe --always --tags`
cmake . -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
./generator/codebrowser_generator -b $BUILD_DIRECTORY -a -o $OUTPUT_DIRECTORY -p codebrowser:$SOURCE_DIRECTORY:$VERSION
./indexgenerator/codebrowser_indexgenerator $OUTPUT_DIRECTORY
cp -rv ./data $DATA_DIRECTORY
