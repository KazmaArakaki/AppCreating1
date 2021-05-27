import UIKit

class ActivityIndicatorView: UIView {
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

    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false

        if let customView = Bundle(for: type(of: self)).loadNibNamed("ActivityIndicatorView", owner: self, options: nil)?.first as? UIView {
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
