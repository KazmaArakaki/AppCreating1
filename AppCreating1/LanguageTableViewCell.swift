import UIKit

protocol LanguageTableViewCellDelegate {
    func languageTableViewCell(tapped cell: LanguageTableViewCell, language: Language)
}

extension LanguageTableViewCellDelegate {
    func languageTableViewCell(tapped cell: LanguageTableViewCell, language: Language) {}
}

class LanguageTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedIndicator: UIImageView!

    var delegate: LanguageTableViewCellDelegate?

    private var language: Language!

    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self, selector: #selector(userSessionSaved(_:)), name: .UserSessionSaved, object: nil)

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setLanguage(_ language: Language) {
        self.language = language

        nameLabel.text = language.name

        if language.shortKey == UserSession.current.languageShortKey {
            selectedIndicator.isHidden = false
        } else {
            selectedIndicator.isHidden = true
        }
    }

    @objc private func tap(_ sender: UITapGestureRecognizer) {
        delegate?.languageTableViewCell(tapped: self, language: language)
    }

    @objc private func userSessionSaved(_ sender: Notification) {
        if language.shortKey == UserSession.current.languageShortKey {
            selectedIndicator.isHidden = false
        } else {
            selectedIndicator.isHidden = true
        }
    }
}
