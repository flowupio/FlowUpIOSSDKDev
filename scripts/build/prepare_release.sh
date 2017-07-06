#!/bin/bash

PODSPEC_VERSION=$(cat SDK/FlowUpIOSSDK.podspec | grep 's.version ' | awk '{print $3}' | tr -d '"')

echo "Building library for iphone"
xcodebuild -workspace FlowUpIOSSDK.xcworkspace -scheme 'SDK' -configuration Release -arch arm64 -arch armv7 -arch armv7s only_active_arch=no defines_module=yes -sdk "iphoneos" clean build

echo "Building library for simulator"
xcodebuild -workspace FlowUpIOSSDK.xcworkspace -scheme 'SDK' -configuration Release -arch x86_64 -arch i386 only_active_arch=no defines_module=yes -sdk "iphonesimulator" clean build

echo "Merging both iphone & simulator libraries" 
lipo -create -output "SDK/libFlowUpIOSSDK.a" "DerivedData/FlowUpIOSSDK/Build/Products/Release-iphoneos/libSDK.a" "DerivedData/FlowUpIOSSDK/Build/Products/Release-iphonesimulator/libSDK.a"

echo "Copying library files to release submodule"
cp SDK/libFlowUpIOSSDK.a release
cp SDK/FlowUpIOSSDK.podspec release
mkdir -p release/SDK
cp SDK/SDK/FlowUp.h release/SDK
cp SDK/SDK/module.modulemap release/SDK

echo "Linting project"
cd release
pod lib lint

if [ $? -ne 0 ]; then
    echo "There was an error during the linting step. Exiting"
    git reset --hard
    exit
fi

echo "Commiting new version $PODSPEC_VERSION"
git add .
git ci -m "Release $PODSPEC_VERSION"
git tag $PODSPEC_VERSION