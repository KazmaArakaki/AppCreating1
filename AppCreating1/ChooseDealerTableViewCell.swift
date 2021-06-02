import UIKit

protocol ChooseDealerTableViewCellDelegate {
    func chooseDealerTableViewCell(tapped cell: ChooseDealerTableViewCell, playerIndex: Int)
}

extension ChooseDealerTableViewCellDelegate {
    func chooseDealerTableViewCell(tapped cell: ChooseDealerTableViewCell, playerIndex: Int) {}
}

class ChooseDealerTableViewCell: UITableViewCell {
    var delegate: ChooseDealerTableViewCellDelegate?

    @IBOutlet weak var playerNameText: UILabel!

    private var playerIndex: Int!

    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self, selector: #selector(gameSessionPlayerDealerIndexModified(_:)), name: .GameSessionPlayerDealerIndexModified, object: nil)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setPlayerIndex(_ playerIndex: Int) {
        self.playerIndex = playerIndex

        if GameSession.current.players.indices.contains(playerIndex) {
            let player = GameSession.current.players[playerIndex]

            playerNameText.text = player.name
        }
    }

    func updateAppearance() {
        if GameSession.current.playerDealerIndex == playerIndex {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }

    @objc private func tap(_ sender: UITapGestureRecognizer) {
        delegate?.chooseDealerTableViewCell(tapped: self, playerIndex: playerIndex)
    }

    @objc private func gameSessionPlayerDealerIndexModified(_ sender: Notification) {
        updateAppearance()
    }
}
