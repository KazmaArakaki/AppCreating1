import UIKit

@IBDesignable
class BaseButton: UIButton {
    var baseColor: CGColor? = UIColor.blue.cgColor
    var cornerRadius: CGFloat = 12.0
    var padding = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)

    var borderColor: CGColor? = UIColor.white.cgColor
    var borderWidth: CGFloat = 1.5
    var borderOffset: CGFloat = 3.0

    var fontName = "Yuanti SC Bold"
    var fontSize: CGFloat = 16.0
    var textColor: UIColor? = UIColor.white

    private let backgroundLayer = CALayer()
    private let borderLayer = CAShapeLayer()

    private var defaultTransform: CGAffineTransform? = nil
    private var shrinkedScaleTransform: CGAffineTransform? = nil

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

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel?.font = UIFont(name: fontName, size: fontSize)

        backgroundLayer.frame = bounds

        borderLayer.path = {
            let offset: CGFloat = borderOffset
            let cornerRadius: CGFloat = self.cornerRadius - borderOffset
            let topLeft = CGPoint(x: backgroundLayer.frame.minX + offset, y: backgroundLayer.frame.minY + offset)
            let topRight = CGPoint(x: backgroundLayer.frame.maxX - offset, y: backgroundLayer.frame.minY + offset)
            let bottomRight = CGPoint(x: backgroundLayer.frame.maxX - offset, y: backgroundLayer.frame.maxY - offset)
            let bottomLeft = CGPoint(x: backgroundLayer.frame.minX + offset, y: backgroundLayer.frame.maxY - offset)

            let path = UIBezierPath()

            path.move(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y))
            path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
            path.addCurve(to: CGPoint(x: topRight.x, y: topRight.y + cornerRadius),
                    controlPoint1: CGPoint(x: topRight.x - (cornerRadius / 2), y: topRight.y),
                    controlPoint2: CGPoint(x: topRight.x, y: topRight.y + (cornerRadius / 2)))
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius))
            path.addCurve(to: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y),
                    controlPoint1: CGPoint(x: bottomRight.x, y: bottomRight.y - (cornerRadius / 2)),
                    controlPoint2: CGPoint(x: bottomRight.x - (cornerRadius / 2), y: bottomRight.y))
            path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y - cornerRadius),
                    controlPoint1: CGPoint(x: bottomLeft.x + (cornerRadius / 2), y: bottomLeft.y),
                    controlPoint2: CGPoint(x: bottomLeft.x, y: bottomLeft.y - (cornerRadius / 2)))
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + (cornerRadius)))
            path.addCurve(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y),
                    controlPoint1: CGPoint(x: topLeft.x, y: topLeft.y + (cornerRadius / 2)),
                    controlPoint2: CGPoint(x: topLeft.x + (cornerRadius / 2), y: topLeft.y))
            path.close()

            return path.cgPath
        }()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let shrinkedScaleTransform = shrinkedScaleTransform {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = shrinkedScaleTransform
            })
        }

        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let defaultTransform = defaultTransform {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = defaultTransform
            })
        }

        super.touchesEnded(touches, with: event)
    }

    func prepare() {
    }

    private func initialize() {
        prepare()

        clipsToBounds = true

        setTitleColor(textColor, for: .normal)

        contentEdgeInsets = padding

        backgroundLayer.backgroundColor = baseColor
        backgroundLayer.cornerRadius = cornerRadius

        borderLayer.fillColor = nil
        borderLayer.strokeColor = borderColor
        borderLayer.lineWidth = borderWidth

        backgroundLayer.addSublayer(borderLayer)

        layer.addSublayer(backgroundLayer)

        if titleLabel != nil {
            bringSubviewToFront(titleLabel!)
        }

        defaultTransform = transform.scaledBy(x: 1, y: 1)
        shrinkedScaleTransform = transform.scaledBy(x: 0.95, y: 0.95)
    }
}
