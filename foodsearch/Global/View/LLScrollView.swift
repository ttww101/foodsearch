import UIKit
final class LLScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init() {
        self.init(frame: .zero)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
    public func updateConstraints(offset: CGFloat) -> Void {
        UIView.animate(withDuration: 0.5, animations: {
            self.snp.updateConstraints({ (make) in
                make.top.equalToSuperview().offset(offset)
            })
            self.superview?.layoutIfNeeded()
        })
    }
}
