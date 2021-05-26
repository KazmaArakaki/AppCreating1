import Foundation

class QuestionsIndexApiClient: AbstractApiClient {
    struct Result {
        let response: Response
        let questionsData: [[String: Any?]]?
    }

    static let shared = QuestionsIndexApiClient()

    private override init() {
        super.init()

        path = "/questions/index.json"
    }

    func get(callback: ((_ result: Result) -> Void)?) {
        request = URLRequest(url: url)

        request?.httpMethod = "GET"

        resumeDataTask({ response in
            guard
                response.success,
                let questionsData = response.data["questions"] as? [[String: Any?]]
            else {
                let result = Result(response: response, questionsData: nil)

                NotificationCenter.default.post(name: .QuestionsIndexApiClientFailed, object: result)

                callback?(result)

                return
            }

            let result = Result(response: response, questionsData: questionsData)

            NotificationCenter.default.post(name: .QuestionsIndexApiClientSucceeded, object: result)

            callback?(result)
        })
    }
}
