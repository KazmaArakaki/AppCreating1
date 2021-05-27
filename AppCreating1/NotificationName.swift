import Foundation

extension Notification.Name {
    static let GameSessionPlayerAdded = Notification.Name("GameSession.Player.Added")
    static let GameSessionPlayerRemoved = Notification.Name("GameSession.Player.Removed")

    static let TopicsIndexApiClientSucceeded = Notification.Name("TopicsIndexApiClient.Succeeded")
    static let TopicsIndexApiClientFailed = Notification.Name("TopicsIndexApiClient.Failed")

    static let QuestionsIndexApiClientSucceeded = Notification.Name("QuestionsIndexApiClient.Succeeded")
    static let QuestionsIndexApiClientFailed = Notification.Name("QuestionsIndexApiClient.Failed")
}
