import UIKit

@IBDesignable
class InstructionView: UIView {
    struct Instruction {
        let image: UIImage?
        let message: String
    }

    @IBOutlet weak var charactorPreview: UIImageView!
    @IBOutlet weak var instructionText: UILabel!
    @IBOutlet weak var indicator: UIImageView!

    private var instructions: [Instruction] = []
    private var instructionIndex = 0

    private var warnings: [Instruction] = []

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        initialize()
    }

    func setInstructions(_ instructions: [Instruction]) {
        self.instructions = instructions

        self.warnings = []

        charactorPreview.image = instructions.first?.image

        instructionText.text = instructions.first?.message
    }

    func setWarnings(_ warnings: [Instruction]) {
        self.warnings = warnings

        switchInstruction(index: 0)

        UINotificationFeedbackGenerator().notificationOccurred(.error)

        UIView.animate(withDuration: 0.05, delay: 0, options: .autoreverse, animations: {
            self.transform = CGAffineTransform(translationX: 8, y: 2)
        }, completion: { (complete) in
            UIView.animate(withDuration: 0.05, delay: 0, options: .autoreverse, animations: {
                self.transform = CGAffineTransform(translationX: -2, y: -8)
            })
        })
    }

    private func initialize() {
        let bundle = Bundle(for: type(of: self))

        if let customView = bundle.loadNibNamed("InstructionView", owner: self, options: nil)?.first as? UIView {
            customView.frame = bounds

            addSubview(customView)
        }

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))

        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.indicator.transform = CGAffineTransform(translationX: 0, y: 4.0)
        })
    }

    private func switchInstruction(index: Int) {
        let instructions = warnings + self.instructions

        if instructions.indices.contains(index) {
            charactorPreview.image = instructions[instructionIndex].image

            instructionText.text = instructions[instructionIndex].message
        }
    }

    @objc private func tap(_ sender: UITapGestureRecognizer) {
        let instructions = warnings + self.instructions

        instructionIndex = (instructionIndex + 1) % instructions.count

        switchInstruction(index: instructionIndex)
    }
}
