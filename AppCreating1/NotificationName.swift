import Foundation

extension Notification.Name {
    static let UserSessionSaved = Notification.Name("UserSession.Saved")

    static let GameSessionPlayerAdded = Notification.Name("GameSession.Player.Added")
    static let GameSessionPlayerRemoved = Notification.Name("GameSession.Player.Removed")

    static let GameSessionPlayerDealerIndexModified = Notification.Name("GameSession.PlayerDealerIndex.Modified")

    static let TopicsIndexApiClientSucceeded = Notification.Name("TopicsIndexApiClient.Succeeded")
    static let TopicsIndexApiClientFailed = Notification.Name("TopicsIndexApiClient.Failed")

    static let QuestionsIndexApiClientSucceeded = Notification.Name("QuestionsIndexApiClient.Succeeded")
    static let QuestionsIndexApiClientFailed = Notification.Name("QuestionsIndexApiClient.Failed")

    static let LanguagesIndexApiClientSucceeded = Notification.Name("LanguagesIndexApiClient.Succeeded")
    static let LanguagesIndexApiClientFailed = Notification.Name("LanguagesIndexApiClient.Failed")

    static let LocalizedStringsIndexApiClientSucceeded = Notification.Name("LocalizedStringsIndexApiClient.Succeeded")
    static let LocalizedStringsIndexApiClientFailed = Notification.Name("LocalizedStringsIndexApiClient.Failed")
}
