# credits ⇝ https://github.com/MrGcGamer/LibGcUniversalDocumentation/blob/master/install.sh

#!/usr/bin/env bash

# Make sure the THEOS environment variable is set
if [ -z "${THEOS}" ]; then
	echo "THEOS environment variable is missing."
	exit 1
fi

# Exit on error
set -e

# Be verbose
set -v

# Copy the dynamic libraries
cp Library/libkitten.dylib "${THEOS}/lib/"
cp Library/libkitten_rootless.dylib "${THEOS}/lib/iphone/rootless/libkitten.dylib"

# Copy the header files
mkdir -p "${THEOS}/include/Kitten"
cp Library/*.h "${THEOS}/include/Kitten/"

# Copy the module map
cp Library/_module.modulemap "${THEOS}/include/Kitten/module.modulemap"

# We're done
set +v

echo
echo "Installation successful!"
echo
