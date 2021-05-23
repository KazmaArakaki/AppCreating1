import UIKit

@IBDesignable
class PrimaryButton: BaseButton {
    override func prepare() {
        baseColor = UIColor(named: "Purple", in: Bundle(for: type(of: self)), compatibleWith: nil)?.cgColor
        padding.top = 16.0
        padding.bottom = 16.0

        fontSize = 20.0
    }
}
