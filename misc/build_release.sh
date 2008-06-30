#!/bin/bash

bzr up
version="$1"
if [ "$version" = "" ]
then
	echo "You must specify a version"
	exit 1
fi
if [ ! -f LICENSE ]
then
	echo "You must run this script from the top-level directory that contains the LICENSE file."
	echo "For example: misc/build_release.sh \$version"
	exit 1
fi

echo "Building Graphite release $version"

rm -fr build/
mkdir build/
cd build/
base_dir="graphite-$version"

echo "Checking out a pristine copy of trunk"
bzr checkout lp:graphite $base_dir
mv $base_dir/misc/install.py $base_dir

echo "Compressing"
cd build
tar czf ../graphite-${version}.tgz *
cd ..

echo "Done"
ls -lh graphite-${version}.tgz
