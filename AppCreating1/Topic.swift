import UIKit

class Topic {
    var uuid: String!
    var title: String!

    static func fromArray(_ data: [String: Any?]) -> Topic {
        guard
            let uuid = data["uuid"] as? String,
            let title = data["title"] as? String
        else {
            abort()
        }

        return Topic(uuid: uuid, title: title)
    }

    func toArray() -> [String: Any?] {
        return [
            "uuid": uuid,
            "title": title,
        ]
    }

    private init(uuid: String, title: String) {
        self.uuid = uuid
        self.title = title
    }
}
