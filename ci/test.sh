#!/bin/bash

xcodebuild -workspace FlowUpIOSSDK.xcworkspace -scheme 'SDK' -destination 'platform=iOS Simulator,name=iPhone 6s Plus' test CODE_SIGN_IDENTITY=-