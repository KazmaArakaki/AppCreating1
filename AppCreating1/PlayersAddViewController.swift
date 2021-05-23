import UIKit

class PlayersAddViewController: UIViewController {
    @IBOutlet weak var playerCountPicker: UIPickerView!
    @IBOutlet weak var instructionView: InstructionView!

    private var playerCountPickerOptions = [Int](1...100)

    override func viewDidLoad() {
        super.viewDidLoad()

        playerCountPicker.delegate = self
        playerCountPicker.dataSource = self

        instructionView.setInstructions([
            NSLocalizedString("Hello!", comment: "[PlayersAddViewController::viewDidLoad] instruction"),
            NSLocalizedString("Please tell me how many players are there!", comment: "[PlayersAddViewController::viewDidLoad] instruction"),
        ])
    }

    @IBAction func submitButtonTouchUpInside(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Under Development", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
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
