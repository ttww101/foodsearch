import UIKit
final class LLShopViewController: LLViewController, Loadable {
    let viewModel: LLShopViewModel
    private let headerBgView: LLImageView = {
        return LLImageView()
    }()
    private let tableView: LLShopTableView = {
        return LLShopTableView(frame: .zero, style: .plain)
    }()
    private let collectionView: LLCategoryCollectionView = {
        return LLCategoryCollectionView()
    }()
    private lazy var btnAddCart: LLButton = {
        return LLButton(title: viewModel.getCheckoutContext(price: 0), imageName: "icon_checkout")
    }()
    private lazy var lblNoData: UILabel = {
        let lbl = UILabel()
        lbl.text = Configuration.Context.noProductData
        return lbl
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(shop: LLShop) {
        viewModel = LLShopViewModel(shop: shop)
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getTitle()
        setupViews()
        setupEvents()
        setupBindings()
        makeRequest()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        super.viewWillDisappear(true)
    }
}
extension LLShopViewController {
    private func setupViews() {
        view.addSubview(headerBgView)
        headerBgView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(offset)
            make.top.equalTo(headerBgView.snp.bottom).offset(4.0)
            make.height.equalTo(44.0)
        }
        view.addSubview(btnAddCart)
        btnAddCart.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4.0)
            make.height.equalTo(44.0)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(4.0)
            make.bottom.equalTo(btnAddCart.snp.top).offset(-4.0)
        }
    }
    private func setupEvents() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(LLShopViewController.back))
        _ = btnAddCart.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                self?.setupAlertView("標題",
                               message: "已成功加入訂單了，請到訂單頁面搜尋",
                               confirm: Configuration.Context.confirm)
        }
        
        headerBgView.load(with: viewModel.getImageURL(), placeholder: "default_food")
        collectionView.didClick = { [weak self] categoryId in
            guard let self = self else { return }
            let products = self.viewModel.getProductsBy(categoryId: categoryId)
            if let products = products?.products {
                self.tableView.products = products
            }
        }
    }
    private func setupBindings() {
        _ = LLShopManager.share.totalPrice
            .observeNext { [weak self] price in
                guard let self = self else { return }
                let context = self.viewModel.getCheckoutContext(price: price)
                self.btnAddCart.setTitle(context, for: .normal)
        }
        _ = viewModel.seriesSignal
            .observeNext { [weak self] series in
                self?.stopLoading()
                guard let self = self else { return }
                guard let series = series else { return }
                if series.isEmpty {
                    self.showEmpty()
                    return
                }
                self.collectionView.setContents(categories: series)
                if let first = series.first {
                    self.tableView.setupContents(products: first.products,
                                                 imagePath: first.imgpath)
                }
        }
    }
    private func navigateToCartViewController() {
        navigationController?.pushViewController(LLCartViewController(), animated: true)
    }
    private func makeRequest() {
        viewModel.makeRequest()
    }
    private func showEmpty() {
        view.addSubview(lblNoData)
        lblNoData.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerBgView.snp.bottom).offset(offset * 2)
        }
    }
    @objc private func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
