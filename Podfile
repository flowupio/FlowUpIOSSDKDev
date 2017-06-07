workspace 'FlowUpIOSSDK'
platform :ios, '8.0'
inhibit_all_warnings!

def sdk_pods
  pod 'AFNetworking', '= 3.1.0'
end

def sdk_test_pods
  pod 'Nocilla', '~> 0.11.0'
  pod 'Nimble', '~> 7.0.0'
  pod 'OCMockito', '~> 4.1.0'
end

target 'Demo' do
  project 'Demo/Demo.xcodeproj'
  pod 'FlowUpIOSSDK', :path => 'SDK'
  sdk_pods
end

target 'Tests' do
  platform :ios, '9.0'
  project 'SDK/SDK.xcodeproj'
  use_frameworks!
  sdk_pods
  sdk_test_pods
end