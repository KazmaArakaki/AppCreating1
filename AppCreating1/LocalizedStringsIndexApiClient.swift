import Foundation

class LocalizedStringsIndexApiClient: AbstractApiClient {
    struct Result {
        let response: Response
        let localizedStringsData: [[String: Any?]]?
    }

    static let shared = LocalizedStringsIndexApiClient()

    private override init() {
        super.init()

        path = "/localized-strings/index.json"
    }

    func get(callback: ((_ result: Result) -> Void)?) {
        queryItems.append(URLQueryItem(name: "language_short_key", value: UserSession.current.languageShortKey))

        request = URLRequest(url: url)

        request?.httpMethod = "GET"

        resumeDataTask({ response in
            guard
                response.success,
                let localizedStringsData = response.data["localized_strings"] as? [[String: Any?]]
            else {
                let result = Result(response: response, localizedStringsData: nil)

                NotificationCenter.default.post(name: .LocalizedStringsIndexApiClientFailed, object: result)

                callback?(result)

                return
            }

            let result = Result(response: response, localizedStringsData: localizedStringsData)

            NotificationCenter.default.post(name: .LocalizedStringsIndexApiClientSucceeded, object: result)

            callback?(result)
        })
    }
}
