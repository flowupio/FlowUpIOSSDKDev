#!/bin/bash

command -v synx >/dev/null 2>&1 || { gem install synx; }

synx Demo/Demo.xcodeproj
synx SDK/SDK.xcodeproj

if [ -n "$(git status --porcelain)" ]; then 
    echo "The project has not been synx'ed"
    exit -1
fi