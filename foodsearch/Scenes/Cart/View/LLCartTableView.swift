import UIKit
import Aletheia
final class LLCartTableView: UITableView {
    private let identifier: String = "Identifier"
    private let sIdentifier: String = "CartIdentifier"
    private let subtotalEachRowHeight = 33
    private var subtotals: [LLSubtotals]
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(subtotals: [LLSubtotals]) {
        self.subtotals = subtotals
        super.init(frame: .zero, style: .plain)
        setup()
    }
    private func setup() {
        register(LLCartTableViewCell.self, forCellReuseIdentifier: identifier)
        register(LLCartSubtitleTableViewCell.self, forCellReuseIdentifier: sIdentifier)
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = .clear
        estimatedRowHeight = 44.0
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        rowHeight = UITableView.automaticDimension
    }
}
extension LLCartTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (section == LLShopManager.share.items.count - 1)
            ? CGFloat(subtotals.count * subtotalEachRowHeight) : 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 44.0 : 22.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == LLShopManager.share.items.count - 1 ) {
            let frame = CGRect(x: 0, y: 0,
                               width: Int(ALScreen.width),
                               height: subtotals.count * subtotalEachRowHeight)
            return LLCartFooterView(frame: frame,
                             subtotals: subtotals,
                             subtotalEachRowHeight: subtotalEachRowHeight)
        }
        return nil
    }
}
extension LLCartTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return LLShopManager.share.items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LLCartTableViewCell
        cell.setupItem(item: LLShopManager.share.items[indexPath.section])
        return cell
    }
}
