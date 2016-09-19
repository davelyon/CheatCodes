import UIKit

fileprivate typealias Cheat = Selector
fileprivate extension Cheat {
    static let tint                 = #selector(UIKeyCommand.toggleTintAdjustmentMode)
    static let userDefaults         = #selector(UIKeyCommand.dumpUserDefaults)
    static let autolayoutTrace      = #selector(UIKeyCommand.autolayoutTrace)
    static let docsDirectory        = #selector(UIKeyCommand.showDocumentsPath)
    static let help                 = #selector(UIKeyCommand.showHelp)
    static let traitCollection      = #selector(UIKeyCommand.showCurrentTraitCollection)
    static let dumpDetails          = #selector(UIKeyCommand.showDeviceDetails)
    static let enableInteraction    = #selector(UIKeyCommand.enableUserInteraction)
}

// MARK: - Cheat Codes Public Infterface
/// CheatCodes additions
extension UIKeyCommand {

    #if CHEATS_Release

    /// :nodoc:
    @nonobjc public static let cheatCodes: [UIKeyCommand] = []

    #else

    /// Installed CheatCodeCommands
    @nonobjc public static var cheatCodes: [UIKeyCommand] {
        return cheatCodeCommands.map { $0.toKeyCommand() }
    }

    #endif

    /** Add a cheat code to the list of known cheat codes.

    This will enable the code to be shown in the `help` output, and
    will make it globally available

    - parameter command:    A new instance of `CheatCodeCommand` to register for
                            availability throughout your app
    */
    @nonobjc public static func addCheatCode(_ command: CheatCodeCommand) {
        cheatCodeCommands.append(command)
    }

    public typealias FormatterContentsBlock = ((inout FormattedKeyValuePrinter) -> Void)
    /** 
    
    Create and use a print formatter that prints out a table of Key/Value pairs

    - parameter title:    The title of the data set
    - parameter contents:   A block that yields a `FormattedKeyValuePrinter`
                            you may call `addKey(_: String, value: String)` on
                            to add items to the formatted output
     */
    @nonobjc public func tableFormatted(title: String, contents: FormatterContentsBlock) {
        var formatter = FormattedKeyValuePrinter(title: title)
        contents(&formatter)
        formatter.printContents()
    }

}

// MARK: - Cheat Codes Private Interface
internal extension UIKeyCommand {
    #if CHEATS_Release
        // Don't include cheat code commands for `release` builds
    #else

    @nonobjc static var cheatCodeCommands = [
        CheatCodeCommand(input: "h", action: .help, discoverabilityTitle: "Print the list of available commands"),
        CheatCodeCommand(input: "t", action: .tint, discoverabilityTitle: "Cycle tintAdjustmentMode"),
        CheatCodeCommand(input: "u", action: .userDefaults, discoverabilityTitle: "Print user defaults"),
        CheatCodeCommand(input: "l", action: .autolayoutTrace, discoverabilityTitle: "Print autolayout backtrace"),
        CheatCodeCommand(input: "d", action: .docsDirectory, discoverabilityTitle: "Print documents directory path"),
        CheatCodeCommand(input: "o", action: .traitCollection, discoverabilityTitle: "Print the current trait collection (for the main window)"),
        CheatCodeCommand(input: "i", action: .dumpDetails, discoverabilityTitle: "Print general device info"),
        CheatCodeCommand(input: "e", action: .enableInteraction, discoverabilityTitle: "Re-enable user interaction"),
        ]

    func showHelp() {
        tableFormatted(title: "Available Cheat Codes:") { formatter in
            UIKeyCommand.cheatCodeCommands.sorted(by: { (c1, c2) -> Bool in
                c1.input <= c2.input
            }).forEach {
                formatter.addKey(" \($0.keyCombo)", value: $0.discoverabilityTitle)
            }
        }
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
        print(UserDefaults.standard.dictionaryRepresentation() as NSDictionary)
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
            print("Documents Directory: <#\(url)#"+">")
        }
    }

    /// Print the current trait collection details for the main window
    func showCurrentTraitCollection() {
        guard let window = UIApplication.shared.keyWindow else { return }

        let allTraits = window.traitCollection.debugDescription
            .components(separatedBy: ";")[1]
            .components(separatedBy: ",")

        let kvs: [[String]] = allTraits.map { traitString in
            traitString
                .replacingOccurrences(of: " _UITraitName", with: "")
                .components(separatedBy: " = ")
        }

        tableFormatted(title: "Current Trait Collection") { formatter in
            kvs.forEach { formatter.addKey($0[0], value: $0[1]) }
        }
    }

    /// Print generic device details
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
    #endif
}








