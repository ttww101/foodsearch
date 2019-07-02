import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LLUserManager.share.retrive()
        self.setupNavigationBarAppearance()
        self.setupBarButtonItemAppearance()
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
    }
}
extension AppDelegate {
    private func setupNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = Configuration.Theme.navigationTitleColor
        UINavigationBar.appearance().barTintColor = Configuration.Theme.main
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: Configuration.Theme.navigationTitleColor,
             NSAttributedString.Key.font: Configuration.Font.system]
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes =
                [NSAttributedString.Key.foregroundColor: Configuration.Theme.navigationTitleColor]
        }
    }
    private func setupBarButtonItemAppearance() {
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: Configuration.Theme.main,
             NSAttributedString.Key.font: Configuration.Font.system],
                                            for: .normal)
    }
}
