import UIKit
import AVKit

class PlayersChooseDealerController: UIViewController {
    @IBOutlet weak var pickQuestionButton: UIButton!
    @IBOutlet weak var questionTextContainer: UIView!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var repickQuestionButton: UIButton!
    @IBOutlet weak var instructionView: InstructionView!

    private var questionPickAnimationView: QuestionPickAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        questionPickAnimationView = QuestionPickAnimationView(frame: .zero)

        questionPickAnimationView.isHidden = true
        questionPickAnimationView.delegate = self

        view.addSubview(questionPickAnimationView)

        instructionView.setInstructions([
            InstructionView.Instruction(image: UIImage(named: "Steward"), message: NSLocalizedString("Next, We choose a dealer. Please tap `Pick Question!` button.", comment: "[PlayersChooseDealerController::viewDidLoad] instruction")),
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
                InstructionView.Instruction(image: UIImage(named: "Steward"), message: NSLocalizedString("Please answer the question shown in turn orally.", comment: "[PlayersChooseDealerController::viewDidLoad] instruction")),
                InstructionView.Instruction(image: UIImage(named: "King"), message: NSLocalizedString("The person, who is closest to the condition in the question, is to be the first dealer.", comment: "[PlayersChooseDealerController::viewDidLoad] instruction")),
                InstructionView.Instruction(image: UIImage(named: "King"), message: NSLocalizedString("OK, Now, you, holding this device and staring at me, answer first!", comment: "[PlayersChooseDealerController::viewDidLoad] instruction")),
            ])
        }
    }
}
