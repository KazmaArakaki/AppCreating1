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

    func getRandom(count: Int) -> [Topic]? {
        guard
            let jsonData = try? Data(contentsOf: TopicRegistry.dataFileUrl),
            let topicsData = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any?]]
        else {
            return nil
        }

        var topics: [Topic] = []

        while (topics.count < count) {
            if let topicData = topicsData.randomElement() {
                let topic = Topic.fromArray(topicData)

                if !topics.contains(where: { $0.uuid == topic.uuid }) {
                    topics.append(topic)
                }
            }
        }

        return topics
    }
}
