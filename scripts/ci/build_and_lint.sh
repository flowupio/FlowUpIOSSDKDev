#!/bin/bash

command -v infer >/dev/null 2>&1 || { brew install infer; }

infer run -- xcodebuild -workspace FlowUpIOSSDK.xcworkspace -scheme 'SDK' -destination 'platform=iOS Simulator,name=iPhone 6s Plus' clean build test CODE_SIGN_IDENTITY=-