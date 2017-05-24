# FlowUpIOSSDK ![https://www.bitrise.io/app/4c566adacab90e25/status.svg?token=VV_e-QYrTBvfuhChTvS9iw&branch=master](https://www.bitrise.io/app/4c566adacab90e25/status.svg?token=VV_e-QYrTBvfuhChTvS9iw&branch=master)
iOS SDK to collect performance metrics easily using http://flowup.io

# Build
The project is in a workspace composed of two projects, the `Demo` project and the `SDK` project. The SDK project is what we distribute to our clients and the Demo project is just an iOS application having the SDK as a dependency to do manual testing and see that everything is working just fine.

To build the SDK, open the `FlowUpIOSSDK.xcworkspace` file with XCode, select the SDK target and press the build button. The output static library is located at `DerivedData/FlowUpIOSSDK/Build/Products/*/libSDK.a`.
