workspace 'FlowUpIOSSDK'
platform :ios, '7.0'

target 'Demo' do
  project 'Demo/Demo.xcodeproj'
  pod 'FlowUpIOSSDK', :path => 'SDK'
end

def sdk_pods
  pod 'AFNetworking', '~> 3.1.0'
  pod 'AFNetworkActivityLogger', :git => 'https://github.com/AFNetworking/AFNetworkActivityLogger.git', :branch => '3_0_0'
end

def sdk_test_pods
  pod 'Nocilla', '~> 0.11.0'
  pod 'Nimble', '~> 7.0.0'
end

target 'SDK' do
  project 'SDK/SDK.xcodeproj'
  sdk_pods
end

target 'Tests' do
  platform :ios, '9.0'
  project 'SDK/SDK.xcodeproj'
  use_frameworks!
  sdk_pods
  sdk_test_pods
end
