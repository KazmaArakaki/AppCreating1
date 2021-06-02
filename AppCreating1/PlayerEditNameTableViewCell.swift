import UIKit

protocol PlayerEditNameTableViewCellDelegate {
    func playerEditNameTableViewCell(playerIndex: Int)
    func playerEditNameTableViewCell(playerIndex: Int, newName: String)
}

extension PlayerEditNameTableViewCellDelegate {
    func playerEditNameTableViewCell(playerIndex: Int) {}
    func playerEditNameTableViewCell(playerIndex: Int, newName: String) {}
}

class PlayerEditNameTableViewCell: UITableViewCell {
    var delegate: PlayerEditNameTableViewCellDelegate?

    var playerNameFieldLabelStringFormat: String = ""
    var playerIndex: Int = 0

    @IBOutlet weak var playerNameFieldLabel: UILabel!
    @IBOutlet weak var playerNameField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()

        playerNameField.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        playerNameFieldLabel.text = String(format: playerNameFieldLabelStringFormat, playerIndex + 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func playerNameFieldEditingChanged(_ sender: UITextField) {
        delegate?.playerEditNameTableViewCell(playerIndex: playerIndex, newName: playerNameField.text ?? "")
    }
}

extension PlayerEditNameTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.playerEditNameTableViewCell(playerIndex: playerIndex)

        return true
    }
}
