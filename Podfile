source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
inhibit_all_warnings!

target 'SignUp' do
  platform :ios, '10.0'

  # UI
  pod 'PinLayout'
  pod 'SwiftyAttributes'
  pod 'Kingfisher'
  
  # Utils
  pod 'Utility', :git => 'https://github.com/dDomovoj/Utility'
  pod 'Utility/Flowable', :git => 'https://github.com/dDomovoj/Utility'

  # Other
  pod 'SwiftLint'
  pod 'SwiftGen'
end

post_install do |installer| 
  installer.pods_project.build_configurations.each do |config|
    if config.name == 'Debug'
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
    else
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
    end    
  end
end