import UIKit

@IBDesignable
class SecondaryButton: BaseButton {
    override func prepare() {
        baseColor = UIColor.white.cgColor

        borderColor = UIColor(named: "Purple", in: Bundle(for: type(of: self)), compatibleWith: nil)?.cgColor
        borderWidth = 2.0

        textColor = UIColor(named: "Purple", in: Bundle(for: type(of: self)), compatibleWith: nil)
    }
}
