import UIKit
import AVKit

class TopicsChooseViewController: UIViewController {
    @IBOutlet weak var topicsContainer: UIView!
    @IBOutlet weak var topicsLabel: UILabel!
    @IBOutlet weak var topic1Text: UILabel!
    @IBOutlet weak var topic2Text: UILabel!
    @IBOutlet weak var topic3Text: UILabel!
    @IBOutlet weak var selectGameModeButton1: UIButton!
    @IBOutlet weak var selectGameModeButton2: UIButton!
    @IBOutlet weak var instructionView: InstructionView!

    private var localizedStrings: [String: String]!
    private var topicsPickAnimationView = TopicsPickAnimationView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "f3ca8667-943b-458b-b2a9-ddb343f61a16",
            "794dd393-1408-4f8b-9027-bf17ce8f381b",
            "7765dfda-d0c9-4a76-9268-d67d3b12720c",
            "3dd15082-ca0d-4c0d-847b-6ddcd9b511d4",
            "e5522f43-b5df-4228-b532-2a87df2a69fa",
            "10405208-2b86-4a86-ac64-deadf0a3e5d1",
            "d83a012f-4941-4a29-bc07-620830b38fb7",
        ])

        instructionView.delegate = self

        topicsLabel.text = localizedStrings["f3ca8667-943b-458b-b2a9-ddb343f61a16"]

        selectGameModeButton1.setTitle(localizedStrings["794dd393-1408-4f8b-9027-bf17ce8f381b"], for: .normal)

        selectGameModeButton2.setTitle(localizedStrings["7765dfda-d0c9-4a76-9268-d67d3b12720c"], for: .normal)

        instructionView.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "King"), message: localizedStrings["3dd15082-ca0d-4c0d-847b-6ddcd9b511d4"] ?? "..."),
            InstructionView.Instruction(image: UIImage(named: "Steward"), message: localizedStrings["e5522f43-b5df-4228-b532-2a87df2a69fa"] ?? "...")
        ])

        topicsPickAnimationView.isHidden = true
        topicsPickAnimationView.delegate = self

        view.addSubview(topicsPickAnimationView)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        topicsPickAnimationView.frame = view.bounds
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        topicsPickAnimationView.playerLayer.frame = topicsPickAnimationView.videoView.bounds
    }

    @IBAction func selectGameModeButton1TouchUpInside(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Under development", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func selectGameModeButton2(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Under development", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

extension TopicsChooseViewController: InstructionViewDelegate {
    func instructionView(instructionIndex: Int) {
        if GameSession.current.topics.isEmpty && instructionIndex == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.topicsPickAnimationView.isHidden = false

                self.topicsPickAnimationView.playVideo()
            })
        }
    }
}

extension TopicsChooseViewController: TopicsPickAnimationViewDelegate {
    func topicsPickAnimationView(videoEndedWith avPlayerItem: AVPlayerItem) {
        if let topics = TopicRegistry.shared.getRandom(count: 3) {
            topicsPickAnimationView.isHidden = true

            topicsContainer.isHidden = false

            topic1Text.text = topics[0].title
            topic1Text.transform = CGAffineTransform(translationX: 0, y: 24)
            topic1Text.alpha = 0

            UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
                self.topic1Text.transform = CGAffineTransform.identity
                self.topic1Text.alpha = 1
            })

            topic2Text.text = topics[1].title
            topic2Text.transform = CGAffineTransform(translationX: 0, y: 24)
            topic2Text.alpha = 0

            UIView.animate(withDuration: 1.0, delay: 0.5, options: [.curveEaseInOut], animations: {
                self.topic2Text.transform = CGAffineTransform.identity
                self.topic2Text.alpha = 1
            })

            topic3Text.text = topics[2].title
            topic3Text.transform = CGAffineTransform(translationX: 0, y: 24)
            topic3Text.alpha = 0

            UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveEaseInOut], animations: {
                self.topic3Text.transform = CGAffineTransform.identity
                self.topic3Text.alpha = 1
            })

            selectGameModeButton1.isHidden = false
            selectGameModeButton1.transform = CGAffineTransform(translationX: 0, y: 24)
            selectGameModeButton1.alpha = 0

            UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseInOut], animations: {
                self.selectGameModeButton1.transform = CGAffineTransform.identity
                self.selectGameModeButton1.alpha = 1
            })

            selectGameModeButton2.isHidden = false
            selectGameModeButton2.transform = CGAffineTransform(translationX: 0, y: 24)
            selectGameModeButton2.alpha = 0

            UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut], animations: {
                self.selectGameModeButton2.transform = CGAffineTransform.identity
                self.selectGameModeButton2.alpha = 1
            })

            GameSession.current.topics = topics

            instructionView.setInstructions([
                InstructionView.Instruction(image: UIImage(named: "Steward"), message: localizedStrings["10405208-2b86-4a86-ac64-deadf0a3e5d1"] ?? "..."),
                InstructionView.Instruction(image: UIImage(named: "King"), message: localizedStrings["d83a012f-4941-4a29-bc07-620830b38fb7"] ?? "...")
            ])
        }
    }
}
