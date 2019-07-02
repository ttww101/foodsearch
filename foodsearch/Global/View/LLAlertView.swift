import UIKit
enum LLAlertViewModel {}
protocol LLAlertViewProtocol {}
extension LLAlertViewProtocol where Self: LLViewController {
    func setupAlertView(_ title: String,
                        message: String,
                        confirm: String,
                        actionConfirm: (() -> ())? = nil,
                        actionCancel: (() -> ())? = nil) -> Void {
        let alert = UIAlertController(title: title,
                                         message: message,
                                         preferredStyle: .alert)
        let ok = UIAlertAction(title: confirm, style: .default){ _ in
            actionConfirm?()
        }
        let cancel = UIAlertAction(title: Configuration.Context.cancel, style: .cancel){ _ in
            actionCancel?()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
