Changelog:

# Version 0.2.0

### Changes

* Improve public interface and add basic documentation
* Use `[.control,.shift]` for default to avoid colliding with built in commands
* Add `tableFormatted(title: String, contents: FormatterContentsBlock)`

### Table Formatter

Example Usage:

```
func showDeviceDetails() {
  let device = UIDevice.current
    tableFormatted(title: "Device Details") { formatter in
      formatter.addKey("Name", value: device.name)
      formatter.addKey("Model", value: device.model)
      formatter.addKey("System Name", value: device.systemName)
      formatter.addKey("System Version", value: String(device.systemVersion))
      formatter.addKey("Vendor ID", value: device.identifierForVendor?.description ?? "")
    }
}
```

Example Output:

```
Device Details
==============
System Version: 10.0
     Vendor ID: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
         Model: iPad
          Name: iDevice
   System Name: iOS
```

### Update built in commands:

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
