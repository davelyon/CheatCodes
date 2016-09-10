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

struct CheatCodeCommand {
    var input: String
    var modifierFlags: UIKeyModifierFlags
    var action: Selector
    var discoverabilityTitle: String

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

extension UIKeyCommand {
    #if CHEATS_Release
    @nonobjc public static let cheatCodes: [UIKeyCommand] = []
    #else
    @nonobjc static let cheatCodeCommands = [
        CheatCodeCommand(input: "t", modifierFlags: [.control], action: #selector(UIKeyCommand.toggleTintAdjustmentMode), discoverabilityTitle: "Cycle tintAdjustmentMode"),
        CheatCodeCommand(input: "u", modifierFlags: [.control], action: #selector(UIKeyCommand.dumpUserDefaults), discoverabilityTitle: "Print user defaults"),
        CheatCodeCommand(input: "l", modifierFlags: [.control], action: #selector(UIKeyCommand.autolayoutTrace), discoverabilityTitle: "Print autolayout backtrace"),
        CheatCodeCommand(input: "d", modifierFlags: [.control], action: #selector(UIKeyCommand.showDocumentsPath), discoverabilityTitle: "Print autolayout backtrace"),
        CheatCodeCommand(input: "d", modifierFlags: [.control], action: #selector(UIKeyCommand.showDocumentsPath), discoverabilityTitle: "Print documents directory path"),
        CheatCodeCommand(input: "h", modifierFlags: [.control], action: #selector(UIKeyCommand.showHelp), discoverabilityTitle: "Print the list of available commands"),
        ]

    @nonobjc public static let cheatCodes = cheatCodeCommands.map { $0.toKeyCommand() }

    func showHelp() {
        print("Available Cheat Codes:")
        print(UIKeyCommand.cheatCodeCommands.map { $0.description() }.joined(separator: "\n"))
    }

    /// Toggles the tint adjustment mode between `automatic` and `dimmed` on the key window
    func toggleTintAdjustmentMode() {
        guard let window = UIApplication.shared.keyWindow else { return }

        switch window.tintAdjustmentMode {
        case .dimmed:
            print("Switching tint adjustment mode: .automatic")
            window.tintAdjustmentMode = .automatic
        case .automatic, .normal:
            print("Switching tint adjustment mode: .dimmed")
            window.tintAdjustmentMode = .dimmed
        }
    }

    /// Dumps the contents of `NSUserDefaults` to the console
    func dumpUserDefaults() {
        let defaults = UserDefaults.standard
        print(defaults.dictionaryRepresentation() as NSDictionary)
    }

    /// Dumps an autolayout backtrace to the console
    func autolayoutTrace() {
        print(UIApplication.shared.keyWindow?.perform(Selector(("_autolayoutTrace"))))
    }

    /// Force user interaction to be enabled again
    func enableUserInteraction() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }

    /// Show the path to the documents directory
    func showDocumentsPath() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print("<#\(url)#"+">")
        }
    }

    #endif
}
