Pod::Spec.new do |s|
  s.name             = 'CheatCodes'
  s.version          = '0.2.0'
  s.summary          = 'UIKeyCommand shortcuts for debugging applications in the simulator'

  s.description      = <<-DESC
CheatCodes is a drop in tool to enable some basic debugging functionality in the simulator by using `UIKeyCommand`.

Currently, it ships with the following already available:

```
Available Cheat Codes:
======================
 ⇧ + ^ + d: Print documents directory path
 ⇧ + ^ + e: Re-enable user interaction
 ⇧ + ^ + h: Print the list of available commands
 ⇧ + ^ + i: Print general device info
 ⇧ + ^ + l: Print autolayout backtrace
 ⇧ + ^ + o: Print the current trait collection (for the main window)
 ⇧ + ^ + t: Cycle tintAdjustmentMode
 ⇧ + ^ + u: Print user defaults
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
    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'CHEAT_${CONFIGURATION}',
    'SWIFT_VERSION' => '3.0'
    }

end
