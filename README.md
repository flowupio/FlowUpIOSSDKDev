# ![FlowUp Logo][flowuplogo] FlowUpIOSSDK ![https://www.bitrise.io/app/4c566adacab90e25/status.svg?token=VV_e-QYrTBvfuhChTvS9iw&branch=master](https://www.bitrise.io/app/4c566adacab90e25/status.svg?token=VV_e-QYrTBvfuhChTvS9iw&branch=master)

FlowUp iOS SDK, mobile real time applications performance monitoring solution!

FlowUp helps you to radically improve your mobile applications performance with actionable insight into real-time key reports including frame time, frames per second, bandwidth, memory consumption, CPU/GPU performance, disk usage and much more.

## Build

The project is in a workspace composed of two projects, the `Demo` project and the `SDK` project. The SDK project is what is distributed. Its dependencies are hardcoded (for legacy reasons) so there is no need to run cocoapods if you only want to build the library itself. The Demo project is an iOS application having using the SDK and it's used to do manual testing and check that the integration is working just fine.

First of all, run `pod install` to configure and download all dependencies and subprojects. To build the SDK, open the `FlowUpIOSSDK.xcworkspace` file with XCode, select the SDK scheme and press the build button. The output static library is located at `DerivedData/FlowUpIOSSDK/Build/Products/*/libSDK.a`. If you want to test the Demo project instead, just select the Demo scheme and build it from XCode.

## Usage

### Cocoapods

* Include the SDK in your `Podfile`:

```ruby
pod 'FlowUpIOSSDK', '~> 0.0.3'
```

If you are using a different version you can always reference the project locally:

```ruby
pod 'FlowUpIOSSDK', :path => 'YOUR_SDK_PATH'
```

##### _Objective-C_

```objectivec
// YourAppDelegate.h
#import "FlowUp.h"

// YourAppDelegate.m
@implementation YourAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FlowUp application:application
didFinishLaunchingWithOptions:launchOptions
                 apiKey:@"YOUR API KEY";
     isDebugModeEnabled:YES];
     return YES;
}
@end
```

##### _Swift_

```swift
import FlowUp

class YourAppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FlowUp.application(application,
                           didFinishLaunchingWithOptions: launchOptions,
                           apiKey: "YOUR API KEY",
                           isDebugModeEnabled: true)
        return true
    }
}
```

**Remember to always disable the debug mode when building for release.**

* Go to https://flowup.io/ and wait for your data to appear in less than a minute.

## License

---

    Copyright 2018 GoKarumi SL.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

[flowuplogo]: ./art/FlowUpLogo.png
