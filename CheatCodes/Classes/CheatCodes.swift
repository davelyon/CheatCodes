import UIKit

fileprivate typealias Cheat = Selector
fileprivate extension Cheat {
    static let tint             = #selector(UIKeyCommand.toggleTintAdjustmentMode)
    static let userDefaults     = #selector(UIKeyCommand.dumpUserDefaults)
    static let autolayoutTrace  = #selector(UIKeyCommand.autolayoutTrace)
    static let docsDirectory    = #selector(UIKeyCommand.showDocumentsPath)
    static let help             = #selector(UIKeyCommand.showHelp)
}

extension UIKeyCommand {
    #if CHEATS_Release
    @nonobjc public static let cheatCodes: [UIKeyCommand] = []
    #else
    @nonobjc static var cheatCodeCommands = [
        CheatCodeCommand(input: "h", action: .help, discoverabilityTitle: "Print the list of available commands"),
        CheatCodeCommand(input: "t", action: .tint, discoverabilityTitle: "Cycle tintAdjustmentMode"),
        CheatCodeCommand(input: "u", action: .userDefaults, discoverabilityTitle: "Print user defaults"),
        CheatCodeCommand(input: "l", action: .autolayoutTrace, discoverabilityTitle: "Print autolayout backtrace"),
        CheatCodeCommand(input: "d", action: .docsDirectory, discoverabilityTitle: "Print documents directory path"),
        ]

    @nonobjc public static var cheatCodes: [UIKeyCommand] {
        return cheatCodeCommands.map { $0.toKeyCommand() }
    }

    @nonobjc public static func addCheatCode(_ command: CheatCodeCommand) {
        cheatCodeCommands.append(command)
    }

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
