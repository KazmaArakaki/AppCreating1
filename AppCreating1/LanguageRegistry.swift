import UIKit

class LanguageRegistry {
    static let shared = LanguageRegistry()

    static var dataFileUrl: URL {
        get {
            return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
                .appendingPathComponent("Languages.json")
        }
    }

    func fetch(callback: ((_ success: Bool) -> Void)?) {
        var languagesData: [[String: Any?]] = []

        LanguagesIndexApiClient.shared.get(callback: { (result) in
            guard
                result.response.success,
                let fetchedLanguagesData = result.languagesData
            else {
                callback?(false)

                return
            }

            for languageData in fetchedLanguagesData {
                let language = Language.fromArray(languageData)

                languagesData.append(language.toArray())
            }

            guard
                let jsonData = try? JSONSerialization.data(withJSONObject: languagesData, options: []),
                (try? jsonData.write(to: LanguageRegistry.dataFileUrl)) != nil
            else {
                callback?(false)

                return
            }

            callback?(true)
        })
    }

    func listAll() -> [Language] {
        guard
            let jsonData = try? Data(contentsOf: LanguageRegistry.dataFileUrl),
            let languagesData = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any?]]
        else {
            return []
        }

        return languagesData.map({ (languageData) in
            return Language.fromArray(languageData)
        })
    }
}
