import UIKit
import Aletheia
final class LLCartSubtitleTableViewCell: UITableViewCell {
    private let lblSubtitle: UILabel = {
        let lbl = UILabel()
        lbl.font = Configuration.Font.support
        lbl.textColor = Configuration.Theme.subtitle
        return lbl
    }()
    private let offset: CGFloat = {
        return ALScreen.width * 0.1
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
        self.addSubview(lblSubtitle)
        lblSubtitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(offset)
            make.centerY.equalToSuperview()
        }
    }
    func setupSubtitle(text: String) {
        lblSubtitle.text = text
    }
}
