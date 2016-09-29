/** 
    Protocol that indicates a `UIViewController` has opted in to using `CheatCodes`
    
    - requires: Must call `addCheatCodes()` in `viewDidLoad` method to install
                `UIKeyCommands`
    - warning: you are strongly encouraged to wrap your extension in an `#if` block 
                so that it will not be compiled for your app store releases.

            #if CHEATS_ENABLED
            extension MyViewController: CheatCodeResponder { ... }
            #endif
*/
public protocol CheatCodeResponder: class {
    var cheatCodes: [CheatCodeCommand] { get }
}

/** Extenstion to trigger installing `UIKeyCommand`s from `CheatCodeCommands` defined
    in the `UIViewController`'s `cheatCodes` computed var.
    
    - seealso: CheatCodeResponder
*/
public extension UIViewController {
    #if CHEATS_Release
    /// :nodoc:
    @available(iOS 9.0, *)
    func addCheatCodes() { /* Don't do anything in Release builds */ }
    #else
    /**
    Add the cheat codes defined by this ViewController's `cheatCodes` computed var
    - requires: conformance to `CheatCodeResponder`
    */
    @available(iOS 9.0, *)
    func addCheatCodes() {
        guard let viewController = self as? CheatCodeResponder else { return }
        viewController.cheatCodes.forEach { code in
            addKeyCommand(code.toKeyCommand())
        }
    }
    #endif
}
