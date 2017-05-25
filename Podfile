workspace 'FlowUpIOSSDK'
platform :ios, '7.0'

target 'Demo' do
  project 'Demo/Demo.xcodeproj'
  pod 'FlowUpIOSSDK', :path => 'SDK'
end

target 'SDK' do
  project 'SDK/SDK.xcodeproj'
  pod 'AFNetworking', '~> 3.1.0'
  pod 'AFNetworkActivityLogger', :git => 'https://github.com/AFNetworking/AFNetworkActivityLogger.git', :branch => '3_0_0'
end
