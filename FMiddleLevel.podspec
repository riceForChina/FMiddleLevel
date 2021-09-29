#
#  Be sure to run `pod spec lint LPDBPublicModule.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "FMiddleLevel"
  s.version          = '0.0.1'
  s.summary          = 'A short description of FMiddleLevel.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'http://gitlab.xuanke.com/iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'demo' => 'demo@kaochong.com' }
  s.source           = { :git => 'git@gitlab.xuanke.com:iOS/FMiddleLevel.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = "5.0"
  s.ios.deployment_target = '9.0'

  s.source_files = 'FMiddleLevel/Classes/**/*.{h,m,swift}' #正式使用
  s.public_header_files = 'FMiddleLevel/Classes/**/*.h'
  # s.source_files = ['ModuleKit/Classes/**/*','ModuleKit/demo/**/*'] #demo使用
 
  # s.resource_bundles = {
  #   'EasySQLite.Swift' => ['EasySQLite.Swift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'ModuleKit'

end
