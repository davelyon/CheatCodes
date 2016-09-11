import UIKit

public struct CheatCodeCommand {
    public var input: String
    public var modifierFlags: UIKeyModifierFlags
    public var action: Selector
    public var discoverabilityTitle: String

    public init(input: String, modifierFlags: UIKeyModifierFlags = [.control], action: Selector, discoverabilityTitle: String) {
        self.input = input
        self.modifierFlags = modifierFlags
        self.action = action
        self.discoverabilityTitle = discoverabilityTitle
    }
}

extension CheatCodeCommand {
    func toKeyCommand() -> UIKeyCommand {
        if #available(iOS 9.0, *) {
            return UIKeyCommand(input: input, modifierFlags: modifierFlags, action: action, discoverabilityTitle: discoverabilityTitle)
        } else {
            return UIKeyCommand(input: input, modifierFlags: modifierFlags, action: action)
        }
    }

    func description() -> String {
        return "\t\(modifierFlags.printableKeys()) + \(input): \(discoverabilityTitle)"
    }
}
