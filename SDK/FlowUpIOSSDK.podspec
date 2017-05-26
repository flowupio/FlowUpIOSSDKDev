Pod::Spec.new do |s|  
  s.name         = "FlowUpIOSSDK"
  s.version      = "0.0.1"
  s.summary      = "iOS SDK to collect performance metrics easily using https://flowup.io."

  s.homepage     = "https://github.com/Karumi/FlowUpIOSSDK"
  s.license      = 'Karumi'
  s.author       = { "FlowUp" => "flowup@karumi.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :path => '.' }
  s.source_files = 'SDK', 'SDK/**/*.{h,m}'
  s.public_header_files = 'SDK/**/*.h'
  s.resources    = "SDK/*.png"
  s.framework    = 'SystemConfiguration'
  s.requires_arc = true

  s.dependency 'AFNetworking'
  s.dependency 'AFNetworkActivityLogger'

end  