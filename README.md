# FlowUpIOSSDK ![https://www.bitrise.io/app/4c566adacab90e25/status.svg?token=VV_e-QYrTBvfuhChTvS9iw&branch=master](https://www.bitrise.io/app/4c566adacab90e25/status.svg?token=VV_e-QYrTBvfuhChTvS9iw&branch=master)

iOS SDK to collect performance metrics easily using [FlowUp](http://flowup.io)

## Build

The project is in a workspace composed of two projects, the `Demo` project and the `SDK` project. The SDK project is what we distribute to our clients and the Demo project is just an iOS application having the SDK as a dependency to do manual testing and see that everything is working just fine.

To build the SDK, open the `FlowUpIOSSDK.xcworkspace` file with XCode, select the SDK target and press the build button. The output static library is located at `DerivedData/FlowUpIOSSDK/Build/Products/*/libSDK.a`.

## Making a release

1. Update podspec version number.
2. Update `FUPConfiguration.h` version number.
3. Run `./scripts/build/prepare_release.sh`.
4. Run `pod trunk push FlowUpIOSSDK.podspec` (you might want to add the `--allow-warnings` flag if there are warnings).

## Adding a 3rd party library

Given we are distributing a static library we need to follow some special steps to include 3rd party libraries inside the application. The target is to bundle every single dependency in the SDK so that our users don't have to load our own dependencies (including a matching version).

In order to include a library we need to follow these steps:

1. Include the library in the Podfile. This is done to keep consistency and know which version of every library we are using. We also want to compile it so that we can extract the library symbols later on.
2. Compile the project to generate a static library located in `DerivedData/FlowUpIOSSDK/Build/Products/*/{LIBRARY}/{LIBRARY}.a`
3. Run `generate_namespace_header.sh {LIBRARY}.a` to create a header with all the macros prefixing all the symbols with your own (by default, `FUP`). This step is absolutely needed because otherwise, if users load the same library themselves they will have collisions with the library symbol names.
4. Paste the macros inside the `SDK/NamespacedDependencies.h` file.
5. Remove the dependency from the project in the podfile (keep it in the shared `sdk_pods` object though).
6. Create a symbolic link inside the `Dependencies` directory from the Pods library copy to here.
7. Include the symbolic link inside the project so that we build all the classes.
8. Done, now your library will be compiled with the whole project and its names will be prefixed to avoid collisions.
