Pod::Spec.new do |spec|
  spec.author       = "胡式华"
  spec.platform     = :ios
  spec.name         = "cableUi"
  spec.version      = "1.3.1"
  spec.summary      = "cableUi SDK for iOS"
  spec.description  = "cable ui SDK for iOS"
  spec.homepage     = "https://github.com/hushihua/cableUi.git"
  spec.license      = { :type => "Commercial", :text => "@2019 Lema.cm" }
  spec.author       = { "Adam.Hu" => "adam.hu.2018@gmail.com" }
  spec.source       = { :git => "https://github.com/hushihua/cableUi.git", :tag=>"#{spec.version}" }
  spec.source_files = "cableUi.framework/Headers/*.{h}"
  spec.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  spec.requires_arc = true
  spec.ios.deployment_target = "10.0"
  spec.ios.vendored_frameworks = "cableUi.framework"
  
  spec.frameworks = "Foundation", "UIKit"
  spec.swift_version='5.0'
  
  spec.dependency 'iPush'
  spec.dependency 'iChat'
  spec.dependency 'iMApi'
  
  spec.dependency 'AWSS3'
  spec.dependency 'SDWebImage'
  spec.dependency 'SDWebImage/GIF'
  spec.dependency 'IQKeyboardManager', '6.2.1'
  spec.dependency 'TSVoiceConverter'
  spec.dependency 'MJRefresh'
  spec.dependency 'MBProgressHUD'
  spec.dependency 'SnapKit'
  spec.dependency 'SQLite.swift'
#  spec.dependency 'GoogleWebRTC'
  
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
end
