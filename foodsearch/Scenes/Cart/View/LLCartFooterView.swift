import UIKit
import Aletheia
final class LLCartFooterView: UIView {
    private let offset: CGFloat = {
        return ALScreen.width * 0.1
    }()
    private var subtotalEachRowHeight: Int
    init(frame: CGRect, subtotals: [(String, String)], subtotalEachRowHeight: Int) {
        self.subtotalEachRowHeight = subtotalEachRowHeight
        super.init(frame: frame)
        setup()
        setupData(subtotals: subtotals)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        backgroundColor = .clear
    }
    public func setupData(subtotals: [(String, String)]) {
        subtotals.enumerated().forEach { (index, element) in
            let (title, value) = element
            let lblValue = UILabel()
            lblValue.textAlignment = .right
            addSubview(lblValue)
            lblValue.text = value
            lblValue.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-offset)
                make.top.equalTo((index * subtotalEachRowHeight))
                make.height.equalTo(subtotalEachRowHeight)
            }
            let lblTitle = UILabel()
            lblTitle.textAlignment = .right
            addSubview(lblTitle)
            lblTitle.text = title
            lblTitle.snp.makeConstraints { (make) in
                make.top.equalTo((index * subtotalEachRowHeight))
                make.trailing.equalTo(-90.0)
                make.height.equalTo(subtotalEachRowHeight)
            }
        }
    }
}
