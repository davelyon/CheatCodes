import UIKit


/// A descriptor for a CheatCodeCommand that wraps a UIKeyCommand
public struct CheatCodeCommand {
    public let input: String
    public let modifierFlags: UIKeyModifierFlags
    public let action: Selector
    public let discoverabilityTitle: String


    /// Initialize a CheatCode with the same attributes as a UIKeyCommand
    ///
    /// - parameter input:                A key to be used in combination with the modifiers to trigger the action
    /// - parameter modifierFlags:        These constants indicate which modifier keys are pressed. The default value is `[.control, .shift]`
    /// - parameter action:               A `Selector` to call when the specified key combination is triggered
    /// - parameter discoverabilityTitle: A short description for use in the help command, and the system overlay
    public init(input: String, modifierFlags: UIKeyModifierFlags = [.control,.shift], action: Selector, discoverabilityTitle: String) {
        self.input = input
        self.modifierFlags = modifierFlags
        self.action = action
        self.discoverabilityTitle = discoverabilityTitle
    }

    func description() -> String {
        return "\t\(modifierFlags.printableKeys()) + \(input): \(discoverabilityTitle)"
    }
}

internal extension CheatCodeCommand {
    func toKeyCommand() -> UIKeyCommand {
        if #available(iOS 9.0, *) {
            return UIKeyCommand(input: input, modifierFlags: modifierFlags, action: action, discoverabilityTitle: discoverabilityTitle)
        } else {
            return UIKeyCommand(input: input, modifierFlags: modifierFlags, action: action)
        }
    }

    var prettyInput: String {
        switch input {
        case UIKeyInputUpArrow: return "↑"
        case UIKeyInputLeftArrow: return "←"
        case UIKeyInputDownArrow: return "↓"
        case UIKeyInputRightArrow: return "→"
        case UIKeyInputEscape: return "⎋"
        default: return input
        }
    }

    var keyCombo: String {
        return "\(modifierFlags.printableKeys()) + \(prettyInput)"
    }

}
