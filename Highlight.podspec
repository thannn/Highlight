#
# Be sure to run `pod lib lint Highlight.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Highlight'
  s.version          = '0.1.0'
  s.summary          = 'Highlight allows easy highlighting of any UI element.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Highlight any UI element, style it, add text to it.
Usage is intented for explanation/guidance purposes.
                       DESC

  s.homepage         = 'https://github.com/Jonathan Provo/Highlight'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jonathan Provo' => 'provo.jonathan@appwise.be' }
  s.source           = { :git => 'https://github.com/Jonathan Provo/Highlight.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Highlight/Sources/**/*'

  # s.resource_bundles = {
  #   'Highlight' => ['Highlight/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
