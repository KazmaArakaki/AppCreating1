import UIKit

@IBDesignable
class InstructionView: UIView {
    @IBOutlet weak var instructionText: UILabel!
    @IBOutlet weak var indicator: UIImageView!

    private var instructions: [String] = []

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

    func setInstructions(_ instructions: [String]) {
        self.instructions = instructions

        instructionText.text = instructions.first
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

    @objc private func tap(_ sender: UITapGestureRecognizer) {
        if let currentInstruction = instructionText.text {
            var nextIndex = 0

            for (index, instruction) in instructions.enumerated() {
                if instruction == currentInstruction {
                    nextIndex = (index + 1) % instructions.count

                    break
                }
            }

            if instructions.indices.contains(nextIndex) {
                instructionText.text = instructions[nextIndex]
            }
        }
    }
}
