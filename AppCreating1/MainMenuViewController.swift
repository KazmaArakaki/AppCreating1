import UIKit

class MainMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startGameButtonTouchUpInside(_ sender: UIButton) {
        if let playersNavigationViewController = storyboard?.instantiateViewController(withIdentifier: "PlayersNavigation") {
            UIApplication.shared.windows.first?.rootViewController = playersNavigationViewController
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
}
