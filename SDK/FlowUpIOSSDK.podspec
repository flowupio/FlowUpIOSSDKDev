Pod::Spec.new do |s|  
  s.name         = "FlowUpIOSSDK"
  s.version      = "0.0.1"
  s.summary      = "iOS SDK to collect performance metrics easily using https://flowup.io."

  s.homepage     = "https://github.com/Karumi/FlowUpIOSSDK"
  s.license      = 'Karumi'
  s.author       = { "FlowUp" => "flowup@karumi.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'git@github.com:Karumi/FlowUpIOSSDKDev', :tag => s.version.to_s}
  s.framework    = 'SystemConfiguration'
  s.source_files = 'SDK/FlowUp.h'
  s.vendored_libraries = 'libFlowUpIOSSDK.a'
  s.library      = 'sqlite3'
end  