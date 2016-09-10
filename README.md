# CheatCodes

[![Version](https://img.shields.io/cocoapods/v/CheatCodes.svg?style=flat)](http://cocoapods.org/pods/CheatCodes)
[![License](https://img.shields.io/cocoapods/l/CheatCodes.svg?style=flat)](http://cocoapods.org/pods/CheatCodes)
[![Platform](https://img.shields.io/cocoapods/p/CheatCodes.svg?style=flat)](http://cocoapods.org/pods/CheatCodes)

## WARNING

While this pod is configured to make itself essentially empty for "Release" builds, it's possible that your projecy may use an alternate build configuration name for app store releases. You should take care to ensure that this pod is *not* available in any publicly available builds.

## About

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

## Notes

While you will not see the overlay that hints at which items are available, these do in fact work on the iPhone simulators (make sure `Hardware > Keyboard > Connect Hardware Keyboard` is enabled)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 3.0+
* iOS 8+

## Installation

CheatCodes is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CheatCodes"
```

## Author

Dave Lyon, dave@davelyon.net

## License

CheatCodes is available under the MIT license. See the LICENSE file for more info.
