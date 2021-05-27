import UIKit

class KeyboardSpacerView: UIView {
    var minHeight: CGFloat = 0

    private var heightConstraint: NSLayoutConstraint!

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    private func commonInit() {
        removeConstraints(constraints)

        heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: minHeight)

        addConstraint(heightConstraint)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillChangeFrame(notification: Notification) {
        guard
            let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else {
            return
        }

        UIView.animate(withDuration: keyboardAnimationDuration, animations: {
            self.heightConstraint.constant = keyboardRect.size.height
        })
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard
            let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else {
            return
        }

        UIView.animate(withDuration: keyboardAnimationDuration, animations: {
            self.heightConstraint.constant = self.minHeight
        })
    }
}
