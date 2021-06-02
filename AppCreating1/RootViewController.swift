import UIKit

class RootViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var instructionView: InstructionView!

    private var localizedStrings: [String: String]!
    private var fetchProgress: Float = 0

    private var isLocalizedStringsFetched = false
    private var isTopicsFetched = false
    private var isQuestionsFetched = false
    private var isLanguagesFetched = false
    private var isBackgroundAudioDataFetched = false
    private var isButtonEffectAudioDataFetched = false
    private var isQuestionPickAnimationPlayerItemFetched = false

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "a359d712-26f4-418d-9b13-1a5f0640048b",
        ])

        instructionView.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "Steward"), message: localizedStrings["a359d712-26f4-418d-9b13-1a5f0640048b"] ?? "We are downloading game data...")
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        fetchAssets()
    }

    private func fetchAssets() {
        let stepCount = Float(7)

        if !isLocalizedStringsFetched {
            LocalizedStringRegistry.shared.fetch(callback: { (success) in
                guard success else {
                    return self.fetchFailed()
                }

                self.isLocalizedStringsFetched = true

                DispatchQueue.main.async {
                    self.fetchProgress += 1 / stepCount

                    self.progressView.progress = self.fetchProgress

                    self.fetchAssets()
                }
            })

            return
        }

        if !isTopicsFetched {
            TopicRegistry.shared.fetch(callback: { (success) in
                guard success else {
                    return self.fetchFailed()
                }

                self.isTopicsFetched = true

                DispatchQueue.main.async {
                    self.fetchProgress += 1 / stepCount

                    self.progressView.progress = self.fetchProgress

                    self.fetchAssets()
                }
            })

            return
        }

        if !isQuestionsFetched {
            QuestionRegistry.shared.fetch(callback: { (success) in
                guard success else {
                    return self.fetchFailed()
                }

                self.isQuestionsFetched = true

                DispatchQueue.main.async {
                    self.fetchProgress += 1 / stepCount

                    self.progressView.progress = self.fetchProgress

                    self.fetchAssets()
                }
            })

            return
        }

        if !isLanguagesFetched {
            LanguageRegistry.shared.fetch(callback: { (success) in
                guard success else {
                    return self.fetchFailed()
                }

                self.isLanguagesFetched = true

                DispatchQueue.main.async {
                    self.fetchProgress += 1 / stepCount

                    self.progressView.progress = self.fetchProgress

                    self.fetchAssets()
                }
            })

            return
        }

        if !isBackgroundAudioDataFetched {
            if AssetRegistry.shared.backgroundAudioData == nil {
                return self.fetchFailed()
            } else {
                isBackgroundAudioDataFetched = true

                fetchProgress += 1 / stepCount

                self.progressView.progress = self.fetchProgress

                fetchAssets()
            }
        }

        if !isButtonEffectAudioDataFetched {
            if AssetRegistry.shared.buttonEffectAudioData == nil {
                return self.fetchFailed()
            } else {
                isButtonEffectAudioDataFetched = true

                fetchProgress += 1 / stepCount

                self.progressView.progress = self.fetchProgress

                fetchAssets()
            }
        }

        if !isQuestionPickAnimationPlayerItemFetched {
            if AssetRegistry.shared.questionPickAnimationPlayerItem == nil {
                return self.fetchFailed()
            } else {
                isQuestionPickAnimationPlayerItemFetched = true

                fetchProgress += 1 / stepCount

                self.progressView.progress = self.fetchProgress

                fetchAssets()
            }
        }

        DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if
                    let window = UIApplication.shared.windows.first,
                    let mainNavigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigation")
                {
                    window.rootViewController = mainNavigationViewController

                    UIView.transition(with: window, duration: 0.1, options: .transitionCrossDissolve, animations: nil, completion: nil)
                }
            })
        }
    }

    private func fetchFailed() {
        DispatchQueue.main.async {
            let title = "Error"
            let message = "Failed to fetch data from server"

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                self.fetchAssets()
            }))

            self.present(alertController, animated: true, completion: nil)
        }
    }
}
