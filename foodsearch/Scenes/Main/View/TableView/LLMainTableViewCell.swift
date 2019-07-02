import UIKit
import SnapKit
final class LLMainTableViewCell: UITableViewCell {
    public var content: LLShopModel?
    public var onClick: ((_ model: LLShop) -> ())?
    private let identifier = "identifier"
    private lazy var cv: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 186.0, height: 186.0)
        flowLayout.minimumLineSpacing = 16.0
        return UICollectionView(frame:.zero, collectionViewLayout: flowLayout)
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.setupCollectionView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    private func setup() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
    }
    private func setupCollectionView() {
        self.contentView.addSubview(cv)
        cv.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
        cv.backgroundColor = .white
        cv.register(LLMainCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
    }
    public func update(content: LLShopModel) {
        self.content = content
        self.cv.reloadData()
    }
}
extension LLMainTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let content = self.content {
            onClick?(content.data[indexPath.row])
        }
    }
}
extension LLMainTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let content = self.content {
            return content.data.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath) as! LLMainCollectionViewCell
        if let content = self.content {
            cell.setData(data: content.data[indexPath.row])
        }
        return cell
    }
}
