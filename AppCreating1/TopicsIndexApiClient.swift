import Foundation

class TopicsIndexApiClient: AbstractApiClient {
    struct Result {
        let response: Response
        let topicsData: [[String: Any?]]?
    }

    static let shared = TopicsIndexApiClient()

    private override init() {
        super.init()

        path = "/topics/index.json"
    }

    func get(callback: ((_ result: Result) -> Void)?) {
        request = URLRequest(url: url)

        request?.httpMethod = "GET"

        resumeDataTask({ response in
            guard
                response.success,
                let topicsData = response.data["topics"] as? [[String: Any?]]
            else {
                let result = Result(response: response, topicsData: nil)

                NotificationCenter.default.post(name: .TopicsIndexApiClientFailed, object: result)

                callback?(result)

                return
            }

            let result = Result(response: response, topicsData: topicsData)

            NotificationCenter.default.post(name: .TopicsIndexApiClientSucceeded, object: result)

            callback?(result)
        })
    }
}
