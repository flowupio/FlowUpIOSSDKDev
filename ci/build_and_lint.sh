#!/bin/bash

command -v infer >/dev/null 2>&1 || { brew install infer; }
command -v synx >/dev/null 2>&1 || { brew install synx; }

synx Demo/Demo.xcodeproj
synx SDK/SDK.xcodeproj

if [ -n "$(git status --porcelain)" ]; then 
    echo "The project has not been synx'ed"
    exit -1
fi

infer run -- xcodebuild -workspace FlowUpIOSSDK.xcworkspace -scheme 'SDK' -destination 'platform=iOS Simulator,name=iPhone 6s Plus' clean build CODE_SIGN_IDENTITY=-
infer run -- xcodebuild -workspace FlowUpIOSSDK.xcworkspace -scheme 'Demo' -destination 'platform=iOS Simulator,name=iPhone 6s Plus' clean build CODE_SIGN_IDENTITY=-