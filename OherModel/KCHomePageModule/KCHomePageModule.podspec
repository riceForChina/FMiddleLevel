#
# Be sure to run `pod lib lint EasySQLite.Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KCHomePageModule'

  s.version          = '0.0.1'


  s.summary          = 'A short description of KCHomePageModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
收益模块
                       DESC
           
  s.homepage         = 'http://gitlab.xuanke.com/iOSKaochongLibrary/KCHomePageModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'demo' => 'demo@kaochong.com' }
  s.source           = { :git => 'git@gitlab.xuanke.com:iOSKaochongLibrary/KCHomePageModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = "5.0"
  s.ios.deployment_target = '9.0'

  s.source_files = 'KCHomePageModule/Classes/**/*.{h,m,swift}'
   s.resource_bundles = {
     'KCHomePageModuleResource' => ['KCHomePageModule/*.{storyboard,xib,xcassets,json,imageset,png,db}']
   }

#  s.resources  = 'KCHomePageModule/*.db'

  s.public_header_files = 'KCHomePageModule/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'FMiddleLevel'

  
end
