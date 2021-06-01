import UIKit

class FetchAssetsView: UIView {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var instructionView: InstructionView!

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

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if let superview = superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            ])
        }
    }

    func setProgress(_ progress: Float) {
        progressView.progress = progress
    }

    func setInstructions(_ instructions: [InstructionView.Instruction]) {
        instructionView.setInstructions(instructions)
    }

    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false

        let bundle = Bundle(for: type(of: self))

        if let customView = bundle.loadNibNamed("FetchAssetsView", owner: self, options: nil)?.first as? UIView {
            customView.translatesAutoresizingMaskIntoConstraints = false

            addSubview(customView)

            NSLayoutConstraint.activate([
                customView.topAnchor.constraint(equalTo: topAnchor),
                customView.trailingAnchor.constraint(equalTo: trailingAnchor),
                customView.bottomAnchor.constraint(equalTo: bottomAnchor),
                customView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ])
        }
    }
}
