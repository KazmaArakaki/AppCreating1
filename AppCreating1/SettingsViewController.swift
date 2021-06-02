import UIKit

class SettingsViewController: UITableViewController {
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var appVersionTextLabel: UILabel!
    @IBOutlet weak var appVersionText: UILabel!

    var localizedStrings: [String: String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "aa0d2d57-463b-464e-b8a7-83f2ecb589c3",
            "dd0a05e9-cfa9-4634-b795-a7bde0a98976",
            "b8a3a802-cd91-4376-b6e9-50048ad7774a",
            "f3809695-1379-4b02-af4d-ef92a97c0a9a",
            "12cf742b-8fa6-4f60-8d9d-1ed678270695",
            "aa0d2d57-463b-464e-b8a7-83f2ecb589c3",
        ])

        title = localizedStrings["aa0d2d57-463b-464e-b8a7-83f2ecb589c3"]

        languageLabel.text = localizedStrings["f3809695-1379-4b02-af4d-ef92a97c0a9a"]

        appVersionTextLabel.text = localizedStrings["12cf742b-8fa6-4f60-8d9d-1ed678270695"]

        appVersionText.text = String(format: "%@ (%@)", arguments: [
            (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "-",
            (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "-",
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return localizedStrings["dd0a05e9-cfa9-4634-b795-a7bde0a98976"]
        }

        if section == 1 {
            return localizedStrings["b8a3a802-cd91-4376-b6e9-50048ad7774a"]
        }

        return nil
    }
}
