import UIKit

class PlayersNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Purple", in: Bundle.main, compatibleWith: nil) as Any,
        ]
    }
}
