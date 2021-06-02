import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var readInstructionsButton: UIButton!
    @IBOutlet weak var watchTutorialButton: UIButton!
    @IBOutlet weak var showSettingsButton: UIButton!

    private var localizedStrings: [String: String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "103cef56-8797-496f-9d32-5640cc94e750",
            "fc5fb666-d195-4d3f-bcef-a5ae98afd53d",
            "683fdbcb-d546-4964-baa3-c78184682ddf",
            "67c94249-d182-4b83-bf57-bff7b7f5e1eb",
        ])

        navigationItem.backBarButtonItem = UIBarButtonItem()

        startGameButton.setTitle(localizedStrings["103cef56-8797-496f-9d32-5640cc94e750"], for: .normal)

        readInstructionsButton.setTitle(localizedStrings["fc5fb666-d195-4d3f-bcef-a5ae98afd53d"], for: .normal)

        watchTutorialButton.setTitle(localizedStrings["683fdbcb-d546-4964-baa3-c78184682ddf"], for: .normal)

        showSettingsButton.setTitle(localizedStrings["67c94249-d182-4b83-bf57-bff7b7f5e1eb"], for: .normal)
    }

    @IBAction func startGameButtonTouchUpInside(_ sender: UIButton) {
        if
            let window = UIApplication.shared.windows.first,
            let playersNavigationViewController = storyboard?.instantiateViewController(withIdentifier: "PlayersNavigation")
        {
            window.rootViewController = playersNavigationViewController

            UIView.transition(with: window, duration: 0.1, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }

    @IBAction func readInstructionsButtonTouchUpInside(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Under Development", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func watchTutorialButtonTouchUpInside(_ sender: UIButton) {
        if let url = URL(string: "https://www.youtube.com/v/jRRmQL7mpL4") {
            UIApplication.shared.open(url)
        }
    }

    @IBAction func showSettingsButtonTouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: "Settings", sender: nil)
    }
}
