import Foundation

class LanguagesIndexApiClient: AbstractApiClient {
    struct Result {
        let response: Response
        let languagesData: [[String: Any?]]?
    }

    static let shared = LanguagesIndexApiClient()

    private override init() {
        super.init()

        path = "/languages/index.json"
    }

    func get(callback: ((_ result: Result) -> Void)?) {
        request = URLRequest(url: url)

        request?.httpMethod = "GET"

        resumeDataTask({ response in
            guard
                response.success,
                let languagesData = response.data["languages"] as? [[String: Any?]]
            else {
                let result = Result(response: response, languagesData: nil)

                NotificationCenter.default.post(name: .LanguagesIndexApiClientFailed, object: result)

                callback?(result)

                return
            }

            let result = Result(response: response, languagesData: languagesData)

            NotificationCenter.default.post(name: .LanguagesIndexApiClientSucceeded, object: result)

            callback?(result)
        })
    }
}
