import UIKit

class QuestionRegistry {
    static let shared = QuestionRegistry()

    static var dataFileUrl: URL {
        get {
            return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
                .appendingPathComponent("Questions.json")
        }
    }

    func fetch(callback: ((_ success: Bool) -> Void)?) {
        var questionsData: [[String: Any?]] = []

        QuestionsIndexApiClient.shared.get(callback: { (result) in
            guard
                result.response.success,
                let fetchedQuestionsData = result.questionsData
            else {
                callback?(false)

                return
            }

            for questionData in fetchedQuestionsData {
                let question = Question.fromArray(questionData)

                questionsData.append(question.toArray())
            }

            guard
                let jsonData = try? JSONSerialization.data(withJSONObject: questionsData, options: []),
                (try? jsonData.write(to: QuestionRegistry.dataFileUrl)) != nil
            else {
                callback?(false)

                return
            }

            callback?(true)
        })
    }

    func getRandom() -> Question? {
        guard
            let jsonData = try? Data(contentsOf: QuestionRegistry.dataFileUrl),
            let questionsData = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any?]],
            let questionData = questionsData.randomElement()
        else {
            return nil
        }

        let question = Question.fromArray(questionData)

        return question
    }
}
