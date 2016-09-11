import UIKit

extension UIKeyModifierFlags {
    func printableKeys() -> String {
        return [
            (contains(.command), "⌘"),
            (contains(.alternate), "⌥"),
            (contains(.shift), "⇧"),
            (contains(.control), "^"),
            (contains(.alphaShift), "CAPS")
            ]
            .filter { keep, _ -> Bool in
                keep
            }.map { _, str in
                str
            }.joined(separator: " + ")
    }
}
