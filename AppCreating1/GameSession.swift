import UIKit

class GameSession {
    static let current = GameSession()

    var players: [Player] = []

    func addPlayer() {
        let player = Player()

        players.append(player)

        NotificationCenter.default.post(name: .GameSessionPlayerAdded, object: nil)
    }

    func popPlayer() {
        removePlayer(at: players.count - 1)
    }

    func removePlayer(at index: Int) {
        if players.indices.contains(index) {
            players.remove(at: index)
        }

        NotificationCenter.default.post(name: .GameSessionPlayerRemoved, object: nil)
    }

    private init() {
    }

    class Player {
        var name: String = ""
    }
}
