import UIKit
final class LLCategoryCollectionView: UICollectionView {
    private var categories: [LLSeries] = []
    private let identifier: String = "Identifier"
    public var didClick: ((_ categoryId: String) -> ())?
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 44)
        layout.minimumLineSpacing = 6.0
        self.init(frame: .zero, collectionViewLayout: layout)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        self.backgroundColor = .white
        self.register(LLCategoryCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        self.decelerationRate = .fast
        self.alwaysBounceHorizontal = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
    }
    public func setContents(categories: [LLSeries]) {
        self.categories = categories
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
extension LLCategoryCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didClick?(self.categories[indexPath.row].categoryID)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath) as! LLCategoryCollectionViewCell
        cell.setTitle(text: self.categories[indexPath.row].categoryName)
        return cell
    }
}
