import UIKit


/// A descriptor for a CheatCodeCommand that wraps a UIKeyCommand
public struct CheatCodeCommand {
    /** A single-character string constant that will trigger this command when 
        pressed along with `modifierFlags`
    
    - note: Also supports these constants:
    - UIKeyInputUpArrow
    - UIKeyInputDownArrow
    - UIKeyInputLeftArrow
    - UIKeyInputRightArrow
    - UIKeyInputEscape
    */
    public let input: String

    /** A set of `UIKeyModifierFlags` that must be help along with `input` to
        trigger the `UIKeyCommand`
        
    - note: The current default is `[.control, .shift]`
    - note: When using the iOS simulator, `.option` may cause issues due to 
            being used as part of the "Pinch" gesture support. Suggested flags
            are: `[.control, .shift]`, `[.control, .command]`
            and `[.control, .command, .shift]`
    */
    public let modifierFlags: UIKeyModifierFlags

    /// The `#selector` to call when the key command is activated
    public let action: Selector

    /// A description used in an on-screen overlay (on iPad) and in the default
    /// help output for `CheatCodes` in the debug console
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
