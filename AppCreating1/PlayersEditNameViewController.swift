import UIKit

class PlayersEditNameViewController: UIViewController {
    @IBOutlet weak var playerEditNameTable: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var instructionView: InstructionView!

    private var localizedStrings: [String: String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "866dc473-0567-41de-86c6-972134b67c7c",
            "207a5170-11e3-4828-bb15-b06807bfbd47",
            "6237b5fa-5c25-452e-b795-e77ff9a448ed",
            "3cae4b29-756b-482b-be07-936e62220d1e",
        ])

        navigationItem.backBarButtonItem = UIBarButtonItem()

        title = localizedStrings["866dc473-0567-41de-86c6-972134b67c7c"]

        submitButton.setTitle(localizedStrings["6237b5fa-5c25-452e-b795-e77ff9a448ed"], for: .normal)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))

        playerEditNameTable.register(UINib(nibName: "PlayerEditNameTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerEditNameTableViewCell")

        playerEditNameTable.dataSource = self
        playerEditNameTable.delegate = self

        if let playerEditNameTableFooter = playerEditNameTable.tableFooterView {
            playerEditNameTableFooter.frame.size.height = 152 + 108

            playerEditNameTable.tableFooterView = playerEditNameTableFooter
        }

        instructionView.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "King"), message: localizedStrings["3cae4b29-756b-482b-be07-936e62220d1e"] ?? "..."),
        ])
    }

    @IBAction func submitButtonTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: "PlayersChooseDealer", sender: nil)
    }

    @objc private func keyboardWillChangeFrame(notification: Notification) {
        guard
            let playerEditNameTableFooter = playerEditNameTable.tableFooterView,
            let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else {
            return
        }

        UIView.animate(withDuration: keyboardAnimationDuration, animations: {
            playerEditNameTableFooter.frame.size.height = keyboardRect.size.height + 108

            self.playerEditNameTable.tableFooterView = playerEditNameTableFooter
        })
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard
            let playerEditNameTableFooter = playerEditNameTable.tableFooterView,
            let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else {
            return
        }

        UIView.animate(withDuration: keyboardAnimationDuration, animations: {
            playerEditNameTableFooter.frame.size.height = 152 + 108

            self.playerEditNameTable.tableFooterView = playerEditNameTableFooter
        })
    }

    @objc private func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension PlayersEditNameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameSession.current.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerEditNameTable.dequeueReusableCell(withIdentifier: "PlayerEditNameTableViewCell") as! PlayerEditNameTableViewCell

        cell.delegate = self
        cell.playerNameFieldLabelStringFormat = localizedStrings["207a5170-11e3-4828-bb15-b06807bfbd47"] ?? ""
        cell.playerIndex = indexPath.row

        if GameSession.current.players.indices.contains(indexPath.row) {
            cell.playerNameField.text = GameSession.current.players[indexPath.row].name
        }

        return cell
    }
}

extension PlayersEditNameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if GameSession.current.players.count > 2 {
            let deleteAction = UIContextualAction(style: .destructive, title: nil, handler: { (action, view, completionHandler) in
                GameSession.current.removePlayer(at: indexPath.row)

                self.playerEditNameTable.deleteRows(at: [indexPath], with: .left)
            })

            deleteAction.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            deleteAction.image = UIImage(systemName: "trash")?.withTintColor(UIColor.red, renderingMode: .alwaysOriginal)

            let configuration = UISwipeActionsConfiguration(actions: [
                deleteAction
            ])

            configuration.performsFirstActionWithFullSwipe = false

            return configuration
        }

        return nil
    }
}

extension PlayersEditNameViewController: PlayerEditNameTableViewCellDelegate {
    func playerEditNameTableViewCell(playerIndex: Int) {
        let indexPath = IndexPath(row: playerIndex + 1, section: 0)

        if let playerEditNameTableViewCell = playerEditNameTable.cellForRow(at: indexPath) as? PlayerEditNameTableViewCell {
            playerEditNameTableViewCell.playerNameField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }

    func playerEditNameTableViewCell(playerIndex: Int, newName: String) {
        if GameSession.current.players.indices.contains(playerIndex) {
            GameSession.current.players[playerIndex].name = newName
        }
    }
}
