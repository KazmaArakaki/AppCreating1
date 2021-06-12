import UIKit

class SettingsLanguageViewController: UIViewController {
    @IBOutlet weak var languagesTable: UITableView!

    private var localizedStrings: [String: String]!
    private var languages: [Language]!

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "9c45f49d-9fe3-425d-a86a-4079ba833360",
            "1c623835-5c93-44fe-a8be-674019ba6491",
            "fc22faaa-2d8d-4c12-8d37-d6b1c239e39e",
            "ae9102dc-3760-4208-a4a3-4d1a5cbd3b5b",
            "922759ac-2d3e-4088-b0ed-a64684e292d4",
        ])

        title = localizedStrings["9c45f49d-9fe3-425d-a86a-4079ba833360"]

        languages = LanguageRegistry.shared.listAll()

        languagesTable.register(UINib(nibName: "LanguageTableViewCell", bundle: nil), forCellReuseIdentifier: "LanguageTableViewCell")

        languagesTable.dataSource = self
        languagesTable.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension SettingsLanguageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = languagesTable.dequeueReusableCell(withIdentifier: "LanguageTableViewCell") as! LanguageTableViewCell

        cell.delegate = self
        cell.setLanguage(languages[indexPath.row])

        return cell
    }
}

extension SettingsLanguageViewController: UITableViewDelegate {}

extension SettingsLanguageViewController: LanguageTableViewCellDelegate {
    func languageTableViewCell(tapped cell: LanguageTableViewCell, language: Language) {
        let alertController = UIAlertController(title: localizedStrings["1c623835-5c93-44fe-a8be-674019ba6491"], message: localizedStrings["fc22faaa-2d8d-4c12-8d37-d6b1c239e39e"], preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: localizedStrings["ae9102dc-3760-4208-a4a3-4d1a5cbd3b5b"] ?? "", style: .default, handler: { (action) in
            UserSession.current.setLanguageShortKey(language.shortKey)

            if
                let window = UIApplication.shared.windows.first,
                let rootNavigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "RootNavigation")
            {
                window.rootViewController = rootNavigationViewController
            }
        }))

        alertController.addAction(UIAlertAction(title: localizedStrings["922759ac-2d3e-4088-b0ed-a64684e292d4"] ?? "", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}
