# CheatCodes

[![Version](https://img.shields.io/cocoapods/v/CheatCodes.svg?style=flat)](http://cocoapods.org/pods/CheatCodes)
[![License](https://img.shields.io/cocoapods/l/CheatCodes.svg?style=flat)](http://cocoapods.org/pods/CheatCodes)
[![Platform](https://img.shields.io/cocoapods/p/CheatCodes.svg?style=flat)](http://cocoapods.org/pods/CheatCodes)

## About

CheatCodes is a drop in tool to enable debugging functionality in the simulator by using `UIKeyCommand`. It also provides tools to build your own custom commands with formatted output.

The following commands are available by default:

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

## WARNING

While this pod is configured to make itself essentially empty for "Release" builds, it's possible that your project may use an alternate build configuration name for app store releases. You should take care to ensure that this pod is *not* available in any publicly available builds.

## Using

### Flags

In Xcode 8, add to your project under `Active Compilation Conditions` (SWIFT_ACTIVE_COMPILATION_CONDITIONS):

```
Active Compilation Conditions > Debug > CHEATS_ENABLED
```

### Basic Usage

```swift
class AppDelegate {
#if CHEATS_ENABLED
  override var keyCommands: [UIKeyCommand]? {
    return UIKeyCommand.cheatCodes
  }
#endif
}
```

### Adding Custom Commands

```swift
#if CHEATS_ENABLED
extension AppDelegate {

    func configureCustomCheats() {
        [
            CheatCodeCommand(input: "g", action: #selector(logInUser), discoverabilityTitle: "Log in a default user account"),
            CheatCodeCommand(input: "f", modifierFlags: [.command, .alternate], action: #selector(resetFirstRunScreens), discoverabilityTitle: "Reset all first run screens"),

        ].forEach { UIKeyCommand.addCheatCode($0) }

    }

    func logInUser() {
        print("Log in a user")
    }

    func resetFirstRunScreens() {
        print("First run screens reset!")
    }
}
#endif
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
