import UIKit

class PlayersAddViewController: UIViewController {
    @IBOutlet weak var playerCountFieldLabel1: UILabel!
    @IBOutlet weak var playerCountPicker: UIPickerView!
    @IBOutlet weak var playerCountFieldLabel2: UILabel!
    @IBOutlet weak var submitButton: PrimaryButton!
    @IBOutlet weak var instructionView: InstructionView!
    @IBOutlet weak var navigationBackButton: UIBarButtonItem!

    private var localizedStrings: [String: String]!
    private var playerCountPickerOptions = [Int](2...100)

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "1322d520-12cd-46c2-932c-458a2e3037c0",
            "46d1df16-64ba-491e-9d53-7ee06778285c",
            "54e41629-ec57-4a50-9ef7-5c61dac0f8aa",
            "31b1e428-468a-49f3-9ea4-d1552caa38aa",
            "a7d37ccc-641a-44da-a68a-edca1e2a0001",
            "a192bfc8-c9fe-450a-9a92-09d243e9b054",
            "2610dd9d-ec2a-4202-be66-be8b4faf0dd8",
        ])

        navigationItem.backBarButtonItem = UIBarButtonItem()

        navigationBackButton.title = localizedStrings["1322d520-12cd-46c2-932c-458a2e3037c0"]

        title = localizedStrings["46d1df16-64ba-491e-9d53-7ee06778285c"]

        playerCountFieldLabel1.text = localizedStrings["54e41629-ec57-4a50-9ef7-5c61dac0f8aa"]

        playerCountFieldLabel2.text = localizedStrings["31b1e428-468a-49f3-9ea4-d1552caa38aa"]

        submitButton.setTitle(localizedStrings["a7d37ccc-641a-44da-a68a-edca1e2a0001"], for: .normal)

        NotificationCenter.default.addObserver(self, selector: #selector(gameSessionPlayerAdded(_:)), name: .GameSessionPlayerAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gameSessionPlayerRemoved(_:)), name: .GameSessionPlayerRemoved, object: nil)

        playerCountPicker.delegate = self
        playerCountPicker.dataSource = self

        instructionView.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "King"), message: localizedStrings["a192bfc8-c9fe-450a-9a92-09d243e9b054"] ?? "..."),
            InstructionView.Instruction(image: UIImage(named: "Steward"), message: localizedStrings["2610dd9d-ec2a-4202-be66-be8b4faf0dd8"] ?? "..."),
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

    @IBAction func navigationBackButtonAction(_ sender: UIBarButtonItem) {
        if
            let window = UIApplication.shared.windows.first,
            let mainNavigationViewController = storyboard?.instantiateViewController(withIdentifier: "MainNavigation")
        {
            window.rootViewController = mainNavigationViewController

            UIView.transition(with: window, duration: 0.1, options: .transitionCrossDissolve, animations: nil, completion: nil)
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
