import UIKit

class LocalizedStringRegistry {
    static let shared = LocalizedStringRegistry()

    static var dataFileUrl: URL {
        get {
            return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
                .appendingPathComponent("LocalizedStrings.json")
        }
    }

    func fetch(callback: ((_ success: Bool) -> Void)?) {
        var localizedStringsData: [String: Any?] = [:]

        LocalizedStringsIndexApiClient.shared.get(callback: { (result) in
            guard
                result.response.success,
                let fetchedLocalizedStringsData = result.localizedStringsData
            else {
                callback?(false)

                return
            }

            for localizedStringData in fetchedLocalizedStringsData {
                guard
                    let uuid = localizedStringData["uuid"] as? String,
                    let value = localizedStringData["value"] as? String
                else {
                    continue
                }

                localizedStringsData[uuid] = value
            }

            guard
                let jsonData = try? JSONSerialization.data(withJSONObject: localizedStringsData, options: []),
                (try? jsonData.write(to: LocalizedStringRegistry.dataFileUrl)) != nil
            else {
                callback?(false)

                return
            }

            callback?(true)
        })
    }

    func read(uuids: [String]) -> [String: String] {
        var localizedStrings: [String: String] = [:]

        if
            let jsonData = try? Data(contentsOf: LocalizedStringRegistry.dataFileUrl),
            let localizedStringsData = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String]
        {
            for uuid in uuids {
                if let localizedString = localizedStringsData[uuid] {
                    localizedStrings[uuid] = localizedString
                }
            }

            return localizedStrings
        }

        return [:]
    }
}
