#!/bin/sh

#	mailscripts
#	build.sh
#	By Mozilla Public License Version 2.0
#	Copyright (c) 2023 Yao Zi. All rights reserved.

# This script build scripts with lmerge

commonModule=ms-common.lua
scripts="ms-recv ms-stat ms-send ms-fetch-thread ms-mbox-split"

mkdir -p ./build

for script in $scripts
do
	echo Building $script...
	lmerge -ishb -o build/$script -m $script.lua $script.lua ms-common.lua
	chmod 755 build/$script
done

echo Building done
