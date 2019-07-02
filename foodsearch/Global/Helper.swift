import UIKit
import Foundation
import Aletheia
extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
extension UIViewController {
    public func present(with presentedViewController: UIViewController) {
        presentedViewController.providesPresentationContextTransitionStyle = true
        presentedViewController.definesPresentationContext = true
        presentedViewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        presentedViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        self.present(presentedViewController, animated: false, completion: nil)
    }
}
extension AletheiaWrapper where Base == String {
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: base)
    }
    public func isVaildURLString() -> Bool {
        if let url = URL(string: base) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    public func withoutDecimal() -> String? {
        if let subString = base.split(separator: ".").first {
            return String(subString)
        }
        return nil
    }
    var htmlToAttributedString: NSAttributedString? {
        guard
            let data = base.data(using: .utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
