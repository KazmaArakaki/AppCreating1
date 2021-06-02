import UIKit

class UserSession {
    static let current = UserSession()

    static var dataFileUrl: URL {
        get {
            return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
                .appendingPathComponent("UserSession.json")
        }
    }

    var languageShortKey: String = ""

    func setLanguageShortKey(_ languageShortKey: String) {
        self.languageShortKey = languageShortKey

        save()
    }

    private init() {
        if
            let jsonData = try? Data(contentsOf: UserSession.dataFileUrl),
            let userSessionData = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String]
        {
            if let languageShortKey = userSessionData["language_short_key"] {
                self.languageShortKey = languageShortKey
            }
        }

        if languageShortKey.isEmpty {
            let locale = Locale.preferredLanguages.first!
            let fromIndex = locale.index(locale.startIndex, offsetBy: 0)
            let toIndex = locale.index(locale.startIndex, offsetBy: 2)

            languageShortKey = String(locale[fromIndex..<toIndex])
        }
    }

    private func toArray() -> [String: Any?] {
        return [
            "language_short_key": languageShortKey,
        ]
    }

    private func save() {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self.toArray(), options: []) {
            try? jsonData.write(to: UserSession.dataFileUrl)

            NotificationCenter.default.post(name: .UserSessionSaved, object: nil)
        }
    }
}
