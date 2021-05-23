import UIKit

@IBDesignable
class DesignableView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }

        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }

        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor: CGColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }

            return nil
        }

        set {
            if let borderColor: UIColor = newValue {
                layer.borderColor = borderColor.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}
