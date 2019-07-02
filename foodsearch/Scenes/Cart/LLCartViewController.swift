import UIKit
extension LLCartViewController: Loadable {}
final class LLCartViewController: LLViewController {
    private let viewModel = LLCartViewModel()
    private lazy var tableView: LLCartTableView = {
        return LLCartTableView(subtotals: viewModel.getSubtotals())
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Configuration.Context.order
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if view.subviews.contains(tableView) {
            tableView.reloadData()
        }
    }
}
extension LLCartViewController {
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
