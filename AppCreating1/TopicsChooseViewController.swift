import UIKit
import AVKit

class TopicsChooseViewController: UIViewController {
    @IBOutlet weak var instructionView: InstructionView!

    private var localizedStrings: [String: String]!
    private var topicsPickAnimationView = TopicsPickAnimationView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "3dd15082-ca0d-4c0d-847b-6ddcd9b511d4",
            "e5522f43-b5df-4228-b532-2a87df2a69fa",
        ])

        instructionView.delegate = self

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
}

extension TopicsChooseViewController: InstructionViewDelegate {
    func instructionView(instructionIndex: Int) {
        if instructionIndex == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.topicsPickAnimationView.isHidden = false

                self.topicsPickAnimationView.playVideo()
            })
        }
    }
}

extension TopicsChooseViewController: TopicsPickAnimationViewDelegate {
    func topicsPickAnimationView(videoEndedWith avPlayerItem: AVPlayerItem) {
        debugPrint("video end")
    }
}
