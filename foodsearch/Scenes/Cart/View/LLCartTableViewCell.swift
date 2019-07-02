import UIKit
import Aletheia
final class LLCartTableViewCell: UITableViewCell {
    public var onClickAdd: (() -> ())?
    public var onClickMiuns: (() -> ())?
    public let lblAmount: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private let btnAdd: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "icon_add"), for: .normal)
        return btn
    }()
    private let btnMiuns: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "icon_miuns"), for: .normal)
        return btn
    }()
    private let lblTitle: UILabel = {
        return UILabel()
    }()
    private let lblSubtitle: UILabel = {
        return UILabel()
    }()
    private let offset: CGFloat = {
        return ALScreen.width * 0.1
    }()
    private lazy var line: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: offset, y: self.frame.height - 4.0,
                             width: ALScreen.width * 0.8, height: 2)
        layer.backgroundColor = UIColor.black.cgColor
        return layer
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setup() {
        self.selectionStyle = .none
    }
    private func setupViews() {
        self.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(offset)
            make.centerY.equalToSuperview()
        }
        self.addSubview(btnMiuns)
        btnMiuns.snp.makeConstraints { (make) in
            make.width.height.equalTo(26.0)
            make.right.equalToSuperview().offset(-offset)
            make.centerY.equalToSuperview()
        }
        self.addSubview(lblAmount)
        lblAmount.snp.makeConstraints { (make) in
            make.right.equalTo(btnMiuns.snp.left).offset(-16.0)
            make.centerY.equalToSuperview()
        }
        self.addSubview(btnAdd)
        btnAdd.snp.makeConstraints { (make) in
            make.width.height.equalTo(26.0)
            make.right.equalTo(lblAmount.snp.left).offset(-16.0)
            make.centerY.equalToSuperview()
        }
    }
    private func setupEvents() {
        _ = btnMiuns.reactive.controlEvents(.touchUpInside).observeNext {
            self.onClickMiuns?()
        }
        _ = btnAdd.reactive.controlEvents(.touchUpInside).observeNext {
            self.onClickAdd?()
        }
    }
    func setupItem(item: LLItems) {
        self.lblTitle.text = item.product.prodName1
        self.lblAmount.text = String(item.amount)
    }
}
