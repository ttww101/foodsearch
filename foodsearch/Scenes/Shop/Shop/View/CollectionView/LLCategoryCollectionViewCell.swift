import UIKit
import SnapKit
final class LLCategoryCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        return lbl
    }()
    private func setup() {
        self.contentView.backgroundColor = Configuration.Theme.main
        self.contentView.layer.cornerRadius = Configuration.UI.cornerRadius
    }
    private func setupViews() {
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    public func setTitle(text: String) {
        self.title.text = text
    }
}
