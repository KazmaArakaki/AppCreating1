import UIKit
import AVKit

class PlayersChooseDealerController: UIViewController {
    @IBOutlet weak var pickQuestionButton: UIButton!
    @IBOutlet weak var questionTextContainer: UIView!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var repickQuestionButton: UIButton!
    @IBOutlet weak var instructionView: InstructionView!

    private var localizedStrings: [String: String]!
    private var questionPickAnimationView: QuestionPickAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        localizedStrings = LocalizedStringRegistry.shared.read(uuids: [
            "dae2ddeb-c10d-4806-8fbd-155cdab62794",
            "4ad531d7-0d94-469a-a41b-3dbb83d58089",
            "fb07ce03-17ae-4ba7-8981-c03f3f16842b",
            "ef50397d-c364-4089-a7f1-ddb525db6209",
            "0f8eb46d-f075-49c9-95ac-c77c3fcc49f4",
            "21a05288-2a71-4279-bde1-cab29570153c",
            "65a8d3ab-0723-4723-a359-6f7fcdb27f81",
            "2945faa1-a5ce-4b8d-8d60-02331d928faa",
        ])

        title = localizedStrings["dae2ddeb-c10d-4806-8fbd-155cdab62794"]

        pickQuestionButton.setTitle(localizedStrings["4ad531d7-0d94-469a-a41b-3dbb83d58089"], for: .normal)

        questionTextLabel.text = localizedStrings["fb07ce03-17ae-4ba7-8981-c03f3f16842b"]

        repickQuestionButton.setTitle(localizedStrings["ef50397d-c364-4089-a7f1-ddb525db6209"], for: .normal)

        questionPickAnimationView = QuestionPickAnimationView(frame: .zero)

        questionPickAnimationView.isHidden = true
        questionPickAnimationView.delegate = self

        view.addSubview(questionPickAnimationView)

        instructionView.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "Steward"), message: localizedStrings["0f8eb46d-f075-49c9-95ac-c77c3fcc49f4"] ?? "..."),
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        questionPickAnimationView.frame = view.bounds
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        questionPickAnimationView.playerLayer.frame = questionPickAnimationView.videoView.bounds
    }

    @IBAction func pickQuestionButtonTouchUpInside(_ sender: UIButton) {
        questionPickAnimationView.isHidden = false

        questionTextContainer.isHidden = true

        questionPickAnimationView.playVideo()
    }

    @IBAction func repickQuestionButtonTouchUpInside(_ sender: UIButton) {
        questionPickAnimationView.isHidden = false

        questionTextContainer.isHidden = true

        questionPickAnimationView.playVideo()
    }
}

extension PlayersChooseDealerController: QuestionPickAnimationViewDelegate {
    func questionPickAnimationView(videoEndedWith avPlayerItem: AVPlayerItem) {
        if let question = QuestionRegistry.shared.getRandom() {
            pickQuestionButton.isHidden = true

            questionText.text = question.title

            questionTextContainer.isHidden = false

            questionPickAnimationView.isHidden = true

            instructionView.setInstructions([
                InstructionView.Instruction(image: UIImage(named: "Steward"), message: localizedStrings["21a05288-2a71-4279-bde1-cab29570153c"] ?? "..."),
                InstructionView.Instruction(image: UIImage(named: "King"), message: localizedStrings["65a8d3ab-0723-4723-a359-6f7fcdb27f81"] ?? "..."),
                InstructionView.Instruction(image: UIImage(named: "King"), message: localizedStrings["2945faa1-a5ce-4b8d-8d60-02331d928faa"] ?? "..."),
            ])
        }
    }
}
