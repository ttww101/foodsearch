import UIKit
final class LLShopTableView: UITableView {
    var actionClick: ((_ product: LLProduct) -> ())?
    var actionAddItem: (() -> ())?
    var products: [LLProduct] = [] {
        didSet {
            self.reloadData()
        }
    }
    private let identifier: String = "Identifier"
    private var imagePath: String = ""
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        register(LLShopTableViewCell.self, forCellReuseIdentifier: identifier)
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    public func setupContents(products: [LLProduct], imagePath: String) -> Void {
        separatorStyle = .singleLine
        self.imagePath = imagePath
        self.products = products
        self.reloadData()
    }
}
extension LLShopTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionClick?(products[indexPath.row])
    }
}
extension LLShopTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LLShopTableViewCell
        cell.setupProduct(product: products[indexPath.row], imagePath: imagePath)
        cell.actionAddItem = { [weak self] in
            guard let self = self else { return }
            self.actionAddItem?()
        }
        return cell
    }
}
