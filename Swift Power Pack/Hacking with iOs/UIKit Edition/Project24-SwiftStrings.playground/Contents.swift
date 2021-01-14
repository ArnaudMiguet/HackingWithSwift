import UIKit

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("345")

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
    
    func withPrefix(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        return prefix + self
    }
    
    var isNumeric: Bool {
        return Double(self) != nil
    }
    
    var lines: [String] {
        self.split(separator: "\n").map {String($0)}
    }
}

"""
This
is
a
test
""".lines
