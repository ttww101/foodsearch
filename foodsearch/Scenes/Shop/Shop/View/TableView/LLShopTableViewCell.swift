import Bond
import UIKit
import SnapKit
import ReactiveKit
final class LLShopTableViewCell: UITableViewCell {
    public var actionAddItem: (() -> ())?
    public var amount = Observable<UInt>(1)
    private let display: LLImageView = {
        let img = LLImageView()
        img.layer.cornerRadius = Configuration.UI.cornerRadius
        return img
    }()
    private let title: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private let context: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private let price: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private let lblAmount: UILabel = {
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
    private let shopping: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "icon_shopping"), for: .normal)
        return btn
    }()
    private var product: LLProduct?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.setupSubviews()
        self.setupEvents()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    private func setup() {
        backgroundColor = .white
        selectionStyle = .none
    }
    private func setupSubviews() {
        addSubview(display)
        display.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80.0)
        }
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.0)
            make.bottom.equalTo(self.snp.centerY).offset(-8.0)
        }
        addSubview(context)
        context.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4.0)
            make.top.equalTo(title.snp.bottom)
        }
        addSubview(price)
        price.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().offset(-8.0)
        }
        addSubview(shopping)
        shopping.snp.makeConstraints { (make) in
            make.right.equalTo(display.snp.left).offset(-8.0)
            make.centerY.equalTo(price)
            make.width.height.equalTo(26.0)
        }
        addSubview(btnMiuns)
        btnMiuns.snp.makeConstraints { (make) in
            make.right.equalTo(shopping.snp.left).offset(-8.0)
            make.centerY.equalTo(price)
            make.width.height.equalTo(26.0)
        }
        addSubview(lblAmount)
        lblAmount.snp.makeConstraints { (make) in
            make.right.equalTo(btnMiuns.snp.left).offset(-4.0)
            make.centerY.equalTo(price)
        }
        addSubview(btnAdd)
        btnAdd.snp.makeConstraints { (make) in
            make.right.equalTo(lblAmount.snp.left).offset(-4.0)
            make.centerY.equalTo(price)
            make.width.height.equalTo(26.0)
        }
    }
    private func setupEvents() {
        _ = btnMiuns.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                if self.amount.value > 0 {
                    self.amount.value -= 1
                }
        }
        _ = btnAdd.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                self.amount.value += 1
        }
        _ = shopping.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                if let product = self.product {
                    LLShopManager.share.addProductItems(product: product,
                                               amount: self.amount.value)
                    self.amount.value = 1
                    self.actionAddItem?()
                }
        }
        _ = self.amount.observeNext { [weak self] (amount) in
            guard let self = self else { return }
            self.lblAmount.text = "\(amount)"
        }
    }
    public func setupProduct(product: LLProduct?, imagePath: String?) -> Void {
        guard let product = product else { return }
        self.product = product
        title.text = product.prodName1
        if let value = product.price1,
            let price = value.al.withoutDecimal() {
            self.price.text = "$ " + price
        }
            display.image = UIImage(named: "default_food")
//        if let imgfile1 = product.imgfile1, let path = imagePath {
//            let path = path + imgfile1
//            display.load(with: path, placeholder: "default_food")
//        } else {
//            display.image = UIImage(named: "default_food")
//        }
    }
}
