import UIKit
import Aletheia
enum LLTabBar: Int {
    case main = 0
    case order
    case member
    var title: String {
        switch self {
        case .main:
            return "首頁"
        case .order:
            return "我的最愛"
        case .member:
            return "會員"
        }
    }
    var image: UIImage? {
        switch self {
        case .main:
            return UIImage(named: "tabbar_home")
        case .order:
            return UIImage(named: "tabbar_order")
        case .member:
            return UIImage(named: "tabbar_member")
        }
    }
}
final class LLHostTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupTabBar()
        setupViewControllers()
    }
    private lazy var mainNavi: UINavigationController = {
        return UINavigationController(rootViewController: LLMainViewController())
    }()
    private lazy var orderNavi: UINavigationController = {
        return UINavigationController(rootViewController: LLCartViewController())
    }()
    private lazy var memberNavi: UINavigationController = {
        let vc = LLUserManager.share.isLogin() ? LLMemberViewController() : LLLoginViewController()
        return UINavigationController(rootViewController: vc)
    }()
    func switchToLoginViewController() {
        selectedIndex = LLTabBar.member.rawValue
    }
    private func setupTabBarAppearance() {
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
    private func setupViewControllers() {
        viewControllers = [mainNavi, orderNavi, memberNavi]
    }
    private func setupTabBar() {
        settTabBarItem(with: mainNavi, type: .main)
        settTabBarItem(with: orderNavi, type: .order)
        settTabBarItem(with: memberNavi, type: .member)
    }
    private func hiddenTitleWhileSelected() {
        tabBar.tintColor = .clear
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = .clear
        }
    }
    private func settTabBarItem(with navi: UINavigationController, type: LLTabBar) {
        navi.tabBarItem = UITabBarItem(title: type.title, image: type.image, selectedImage: nil)
    }
}
