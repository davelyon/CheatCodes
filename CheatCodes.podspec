#
# Be sure to run `pod lib lint CheatCodes.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CheatCodes'
  s.version          = '0.1.5'
  s.summary          = 'UIKeyCommand shortcuts for debugging applications in the simulator'

  s.description      = <<-DESC
CheatCodes is a drop in tool to enable some basic debugging functionality in the simulator by using `UIKeyCommand`.

Currently, it ships with the following already available:

```
Available Cheat Codes:
^ + t: Cycle tintAdjustmentMode
^ + u: Print user defaults
^ + l: Print autolayout backtrace
^ + d: Print autolayout backtrace
^ + d: Print documents directory path
^ + h: Print the list of available commands
```
DESC

  s.homepage         = 'https://github.com/davelyon/CheatCodes'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dave Lyon' => 'dave@davelyon.net' }
  s.source           = { :git => 'https://github.com/davelyon/CheatCodes.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/daveisonthego'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CheatCodes/Classes/**/*'

  s.pod_target_xcconfig = {
    "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "CHEAT_${CONFIGURATION}",
    'SWIFT_VERSION' => '3.0'
    }
end
