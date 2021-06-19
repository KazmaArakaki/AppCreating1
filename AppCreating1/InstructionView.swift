import UIKit

protocol InstructionViewDelegate {
    func instructionView(instructionIndex: Int)
}

extension InstructionViewDelegate {
    func instructionView(instructionIndex: Int) {}
}

@IBDesignable
class InstructionView: UIView {
    struct Instruction {
        let image: UIImage?
        let message: String
    }

    var delegate: InstructionViewDelegate?

    var instructionIndex = 0

    @IBOutlet weak var charactorPreview: UIImageView!
    @IBOutlet weak var instructionText: UILabel!
    @IBOutlet weak var indicator: UIImageView!

    private var instructions: [Instruction] = []

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

        delegate?.instructionView(instructionIndex: instructionIndex)

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse, .curveEaseOut], animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -24)
            })

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.layer.removeAllAnimations()

                UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut], animations: {
                    self.transform = CGAffineTransform.identity
                })
            })
        }
    }

    func setWarnings(_ warnings: [Instruction]) {
        self.warnings = warnings

        switchInstruction(index: 0)

        delegate?.instructionView(instructionIndex: instructionIndex)

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
            instructionIndex = index

            charactorPreview.image = instructions[instructionIndex].image

            instructionText.text = instructions[instructionIndex].message
        }
    }

    @objc private func tap(_ sender: UITapGestureRecognizer) {
        let instructions = warnings + self.instructions

        instructionIndex = (instructionIndex + 1) % instructions.count

        switchInstruction(index: instructionIndex)

        delegate?.instructionView(instructionIndex: instructionIndex)
    }
}
