import UIKit

class Language {
    var shortKey: String!
    var name: String!

    static func fromArray(_ data: [String: Any?]) -> Language {
        guard
            let shortKey = data["short_key"] as? String,
            let name = data["name"] as? String
        else {
            abort()
        }

        return Language(shortKey: shortKey, name: name)
    }

    func toArray() -> [String: Any?] {
        return [
            "short_key": shortKey,
            "name": name,
        ]
    }

    private init(shortKey: String, name: String) {
        self.shortKey = shortKey
        self.name = name
    }
}
