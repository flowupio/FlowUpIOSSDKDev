#!/bin/bash

PODSPEC_VERSION=$(cat SDK/FlowUpIOSSDK.podspec | grep 's.version\s*=' | awk '{print $3}' | tr -d '"')
CONFIGURATION_VERSION=$(cat SDK/SDK/Infrastructure/Configuration.h | grep SDKVersion | awk '{print $6}' | tr -d '"@;')

if [ "$PODSPEC_VERSION" != "$CONFIGURATION_VERSION" ]; then
    echo "SDK versions found in the podspec ($PODSPEC_VERSION) and the Configuration.h file ($CONFIGURATION_VERSION) does not match"
    exit -1
fi
