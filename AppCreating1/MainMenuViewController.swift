import UIKit

class MainMenuViewController: UIViewController {
    private var fetchAssetsView: FetchAssetsView?

    private var fetchProgress: Float = 0

    private var isTopicsFetched = false
    private var isQuestionsFetched = false
    private var isBackgroundAudioDataFetched = false
    private var isButtonEffectAudioDataFetched = false
    private var isQuestionPickAnimationPlayerItemFetched = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startGameButtonTouchUpInside(_ sender: UIButton) {
        fetchAssetsView = FetchAssetsView()
        fetchProgress = 0

        fetchAssetsView?.setProgress(fetchProgress)

        fetchAssetsView?.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "Steward"), message: NSLocalizedString("We are downloading game data.", comment: "[MainMenuViewController::startGameButtonTouchUpInside] instruction"))
        ])

        view.addSubview(fetchAssetsView!)

        fetchAssets()
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

    private func fetchAssets() {
        let stepCount = Float(5)

        if !isTopicsFetched {
            TopicRegistry.shared.fetch(callback: { (success) in
                guard success else {
                    DispatchQueue.main.async {
                        let title = NSLocalizedString("Error", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")
                        let message = NSLocalizedString("Failed to fetch data from server", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")

                        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

                        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                        self.present(alertController, animated: true, completion: nil)

                        self.fetchAssetsView?.removeFromSuperview()
                    }

                    return
                }

                self.isTopicsFetched = true

                DispatchQueue.main.async {
                    self.fetchProgress += 1 / stepCount

                    self.fetchAssetsView?.setProgress(self.fetchProgress)

                    self.fetchAssets()
                }
            })

            return
        }

        if !isQuestionsFetched {
            QuestionRegistry.shared.fetch(callback: { (success) in
                guard success else {
                    DispatchQueue.main.async {
                        let title = NSLocalizedString("Error", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")
                        let message = NSLocalizedString("Failed to fetch data from server", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")

                        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

                        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                        self.present(alertController, animated: true, completion: nil)

                        self.fetchAssetsView?.removeFromSuperview()
                    }

                    return
                }

                self.isQuestionsFetched = true

                DispatchQueue.main.async {
                    self.fetchProgress += 1 / stepCount

                    self.fetchAssetsView?.setProgress(self.fetchProgress)

                    self.fetchAssets()
                }
            })

            return
        }

        if !isBackgroundAudioDataFetched {
            if AssetRegistry.shared.backgroundAudioData == nil {
                DispatchQueue.main.async {
                    let title = NSLocalizedString("Error", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")
                    let message = NSLocalizedString("Failed to fetch data from server", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")

                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                    self.present(alertController, animated: true, completion: nil)

                    self.fetchAssetsView?.removeFromSuperview()
                }

                return
            } else {
                isBackgroundAudioDataFetched = true

                fetchProgress += 1 / stepCount

                fetchAssetsView?.setProgress(self.fetchProgress)

                fetchAssets()
            }
        }

        if !isButtonEffectAudioDataFetched {
            if AssetRegistry.shared.buttonEffectAudioData == nil {
                DispatchQueue.main.async {
                    let title = NSLocalizedString("Error", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")
                    let message = NSLocalizedString("Failed to fetch data from server", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")

                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                    self.present(alertController, animated: true, completion: nil)

                    self.fetchAssetsView?.removeFromSuperview()
                }

                return
            } else {
                isButtonEffectAudioDataFetched = true

                fetchProgress += 1 / stepCount

                fetchAssetsView?.setProgress(self.fetchProgress)

                fetchAssets()
            }
        }

        if !isQuestionPickAnimationPlayerItemFetched {
            if AssetRegistry.shared.questionPickAnimationPlayerItem == nil {
                DispatchQueue.main.async {
                    let title = NSLocalizedString("Error", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")
                    let message = NSLocalizedString("Failed to fetch data from server", comment: "[MainMenuViewController::startGameButtonTouchUpInside] alert")

                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                    self.present(alertController, animated: true, completion: nil)

                    self.fetchAssetsView?.removeFromSuperview()
                }

                return
            } else {
                isQuestionPickAnimationPlayerItemFetched = true

                fetchProgress += 1 / stepCount

                fetchAssetsView?.setProgress(self.fetchProgress)

                fetchAssets()
            }
        }

        if let playersNavigationViewController = storyboard?.instantiateViewController(withIdentifier: "PlayersNavigation") {
            UIApplication.shared.windows.first?.rootViewController = playersNavigationViewController
        }
    }
}
