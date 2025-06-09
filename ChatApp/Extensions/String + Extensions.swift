import Foundation

extension String {
    var safeDatabaseKey: String {
        return self.replacingOccurrences(of: ".", with: "-")
                    .replacingOccurrences(of: "@", with: "_")
    }
}
