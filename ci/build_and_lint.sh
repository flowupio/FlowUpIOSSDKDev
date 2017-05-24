#!/bin/bash

command -v infer >/dev/null 2>&1 || { brew install infer; }

infer run -- xcodebuild -workspace FlowUpIOSSDK.xcworkspace -scheme 'Demo' -destination 'platform=iOS Simulator,name=iPhone 6s Plus' clean build CODE_SIGN_IDENTITY=-