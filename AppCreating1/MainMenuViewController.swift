import UIKit

class MainMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startGameButtonTouchUpInside(_ sender: UIButton) {
        if let playersNavigationViewController = storyboard?.instantiateViewController(withIdentifier: "PlayersNavigation") {
            let activityIndicatorView = ActivityIndicatorView()

            view.addSubview(activityIndicatorView)

            TopicRegistry.shared.fetch(callback: { (success) in
                guard success else {
                    DispatchQueue.main.async {
                        let title = NSLocalizedString("Error", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")
                        let message = NSLocalizedString("Failed to fetch data from server", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")

                        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

                        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                        self.present(alertController, animated: true, completion: nil)

                        activityIndicatorView.removeFromSuperview()
                    }

                    return
                }

                QuestionRegistry.shared.fetch(callback: { (success) in
                    guard success else {
                        DispatchQueue.main.async {
                            let title = NSLocalizedString("Error", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")
                            let message = NSLocalizedString("Failed to fetch data from server", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")

                            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

                            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                            self.present(alertController, animated: true, completion: nil)

                            activityIndicatorView.removeFromSuperview()
                        }

                        return
                    }

                    DispatchQueue.main.async {
                        UIApplication.shared.windows.first?.rootViewController = playersNavigationViewController
                    }
                })
            })
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
