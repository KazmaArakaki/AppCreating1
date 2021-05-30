import UIKit

class PlayersNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Purple", in: Bundle(for: type(of: self)), compatibleWith: nil) as Any,
            .font: UIFont(name: "Yuanti SC Bold", size: 14) as Any,
        ]

        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: UIFont(name: "Yuanti SC Bold", size: 16) as Any,
        ], for: .normal)
    }
}
