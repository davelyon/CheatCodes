import Foundation

/**
 A simple wrapper around a collection of `(String,String)` (or, (Key,Value)) with a title that prints
 the title, and the dictionary with the keys right aligned to the longest key.
 */
public struct FormattedKeyValuePrinter {
    /// A title for the generated output
    public let title: String

    private var keyValuePairs = [(String,String)]()
    private var maxKeyLength = 0

    init(title: String) {
        self.title = title
    }

    /** Add a key and value to the formatted output
    - parameter key: a descriptor for the value shown
    - parameter value: the relevant piece of data being described
    */
    public mutating func addKey(_ key: String, value: String?) {
        maxKeyLength = max(maxKeyLength, key.characters.count)
        keyValuePairs.append((key,value ?? "(NO VALUE)"))
    }

    func printContents() {

        let line = String(repeating: "=", count: title.characters.count)

        var printableString = "\n\(title)\n\(line)"

        keyValuePairs.forEach { key, value in
            let padLength = maxKeyLength - key.characters.count
            printableString.append("\n\(String(repeating: " ", count: padLength))\(key): \(value)")
        }

        print(printableString)
    }
}
