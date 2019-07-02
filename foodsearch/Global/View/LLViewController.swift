import UIKit
import Aletheia
extension LLViewController: LLAlertViewProtocol {}
class LLViewController: UIViewController {
    let offset: CGFloat = {
        return 8.0
    }()
    override func loadView() {
        let v = UIView(frame: UIScreen.main.bounds)
        v.backgroundColor = .white
        self.view = v
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}
