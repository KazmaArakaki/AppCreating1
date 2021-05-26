import UIKit

class TopicRegistry {
    static let shared = TopicRegistry()

    static var dataFileUrl: URL {
        get {
            return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
                .appendingPathComponent("Topics.json")
        }
    }

    func fetch(callback: ((_ success: Bool) -> Void)?) {
        var topicsData: [[String: Any?]] = []

        TopicsIndexApiClient.shared.get(callback: { (result) in
            guard
                result.response.success,
                let fetchedTopicsData = result.topicsData
            else {
                callback?(false)

                return
            }

            for topicData in fetchedTopicsData {
                let topic = Topic.fromArray(topicData)

                topicsData.append(topic.toArray())
            }

            guard
                let jsonData = try? JSONSerialization.data(withJSONObject: topicsData, options: []),
                (try? jsonData.write(to: TopicRegistry.dataFileUrl)) != nil
            else {
                callback?(false)

                return
            }

            callback?(true)
        })
    }
}
