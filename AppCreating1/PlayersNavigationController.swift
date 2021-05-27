import UIKit

class PlayersNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Purple", in: Bundle(for: type(of: self)), compatibleWith: nil) as Any,
        ]
    }
}
