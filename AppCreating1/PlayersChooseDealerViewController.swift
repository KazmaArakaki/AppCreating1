import UIKit

class PlayersChooseDealerViewController: UIViewController {
    @IBOutlet weak var chooseDealerTable: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var instructionView: InstructionView!

    private var localizedStrings: [String: String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "9d957f69-4c3d-462a-8ea1-b0509d708d52",
            "61ffd17b-b17d-4c82-bf64-49d2a7132c10",
            "1f98d599-3434-4c83-84bc-52f50603e072",
        ])

        navigationItem.backBarButtonItem = UIBarButtonItem()

        title = localizedStrings["9d957f69-4c3d-462a-8ea1-b0509d708d52"]

        submitButton.setTitle(localizedStrings["61ffd17b-b17d-4c82-bf64-49d2a7132c10"], for: .normal)

        instructionView.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "Steward"), message: localizedStrings["1f98d599-3434-4c83-84bc-52f50603e072"] ?? "...")
        ])

        chooseDealerTable.register(UINib(nibName: "ChooseDealerTableViewCell", bundle: nil), forCellReuseIdentifier: "ChooseDealerTableViewCell")

        chooseDealerTable.dataSource = self
        chooseDealerTable.delegate = self

        if let chooseDealerTableFooter = chooseDealerTable.tableFooterView {
            chooseDealerTableFooter.frame.size.height = 152 + 108

            chooseDealerTable.tableFooterView = chooseDealerTableFooter
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        for (index, _) in GameSession.current.players.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = chooseDealerTable.cellForRow(at: indexPath) as? ChooseDealerTableViewCell

            cell?.updateAppearance()
        }
    }

    @IBAction func submitButtonTouchUpInside(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Under Development", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

extension PlayersChooseDealerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameSession.current.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chooseDealerTable.dequeueReusableCell(withIdentifier: "ChooseDealerTableViewCell") as! ChooseDealerTableViewCell

        cell.delegate = self

        cell.setPlayerIndex(indexPath.row)

        return cell
    }
}

extension PlayersChooseDealerViewController: UITableViewDelegate {}

extension PlayersChooseDealerViewController: ChooseDealerTableViewCellDelegate {
    func chooseDealerTableViewCell(tapped cell: ChooseDealerTableViewCell, playerIndex: Int) {
        GameSession.current.playerDealerIndex = playerIndex
    }
}
