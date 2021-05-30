import UIKit

class PlayersAddViewController: UIViewController {
    @IBOutlet weak var playerCountPicker: UIPickerView!
    @IBOutlet weak var instructionView: InstructionView!

    private var playerCountPickerOptions = [Int](2...100)

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(gameSessionPlayerAdded(_:)), name: .GameSessionPlayerAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gameSessionPlayerRemoved(_:)), name: .GameSessionPlayerRemoved, object: nil)

        playerCountPicker.delegate = self
        playerCountPicker.dataSource = self

        instructionView.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "King"), message: NSLocalizedString("Now, let's get the party started!", comment: "[PlayersAddViewController::viewDidLoad] instruction")),
            InstructionView.Instruction(image: UIImage(named: "Steward"), message: NSLocalizedString("First of all, could you tell me how many players are there?", comment: "[PlayersAddViewController::viewDidLoad] instruction")),
        ])

        GameSession.current.addPlayer()
        GameSession.current.addPlayer()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = segue.destination as? PlayersEditNameViewController {
            let selectedRow = playerCountPicker.selectedRow(inComponent: 0)
            let playerCount = playerCountPickerOptions[selectedRow]

            if playerCount > GameSession.current.players.count {
                while GameSession.current.players.count != playerCount {
                    GameSession.current.addPlayer()
                }
            } else if playerCount < GameSession.current.players.count {
                while GameSession.current.players.count != playerCount  {
                    GameSession.current.popPlayer()
                }
            }
        }
    }

    @IBAction func submitButtonTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: "PlayersEditName", sender: nil)
    }

    @objc private func gameSessionPlayerAdded(_ sender: Notification) {
        if let playerCountPickerOptionIndex = playerCountPickerOptions.firstIndex(of: GameSession.current.players.count) {
            playerCountPicker.selectRow(playerCountPickerOptionIndex, inComponent: 0, animated: false)
        }
    }

    @objc private func gameSessionPlayerRemoved(_ sender: Notification) {
        if let playerCountPickerOptionIndex = playerCountPickerOptions.firstIndex(of: GameSession.current.players.count) {
            playerCountPicker.selectRow(playerCountPickerOptionIndex, inComponent: 0, animated: false)
        }
    }
}

extension PlayersAddViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()

        label.textAlignment = .center
        label.font = UIFont(name: "Yuanti TC Bold", size: 48)
        label.textColor = UIColor(named: "Purple")

        if playerCountPickerOptions.indices.contains(row) {
            label.text = String(format: "%d", playerCountPickerOptions[row])
        }

        return label
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 48
    }
}

extension PlayersAddViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playerCountPickerOptions.count
    }
}
