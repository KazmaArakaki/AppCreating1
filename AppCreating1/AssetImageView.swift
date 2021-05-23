import UIKit

@IBDesignable
class AssetImageView: UIImageView {
    private var _assetName: String? = nil

    @IBInspectable var assetName: String {
        get {
            return _assetName ?? ""
        }

        set {
            _assetName = !newValue.isEmpty ? newValue : nil
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let assetName = _assetName, let image = UIImage(named: assetName, in: Bundle(for: type(of: self)), compatibleWith: nil) {
            self.image = image
        }
    }
}
