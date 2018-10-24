#
# Be sure to run `pod lib lint zhschoolMain.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'zhschoolMain'
  s.version          = '0.1.0'
  s.summary          = 'zhschoolMain测试'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xianguozzt/zhschoolMain'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xianguozzt' => 'xu.han@zhongheschool.com' }
  s.source           = { :git => 'https://github.com/xianguozzt/zhschoolMain.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = '*.swift'
  
  # s.resource_bundles = {
  #   'zhschoolMain' => ['zhschoolMain/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   #s.dependency 'Alamofire'
   #s.dependency 'Reusable'
   #s.dependency 'SnapKit'
   #s.dependency 'Kingfisher'
   #s.dependency 'ReactiveSwift'
   #s.dependency 'HandyJSON'
   #s.dependency 'Result'
   #s.dependency 'MBProgressHUD'
   #s.dependency 'Then'
   #s.dependency 'HMSegmentedControl'
end
