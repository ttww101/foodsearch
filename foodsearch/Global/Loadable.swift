import UIKit
import Foundation
import NVActivityIndicatorView
protocol Loadable { }
extension Loadable {
    func startLoading(at center: CGPoint, onTopOf view: UIView, size: CGSize = CGSize(width: 44, height: 44)) {
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: size), type: .circleStrokeSpin, color: .black, padding: nil)
        activityIndicatorView.center = center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    func stopLoading() {
        var subviews: [UIView] = []
        if let v = (self as? UIViewController)?.view.subviews {
            subviews = v
        }
        if let v = (self as? UIView)?.subviews {
            subviews = v
        }
        for view in subviews {
            if let v = view as? NVActivityIndicatorView {
                v.stopAnimating()
            }
        }
    }
}
