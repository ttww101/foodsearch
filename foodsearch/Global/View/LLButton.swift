import UIKit
final class LLButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(title: String,
                     imageName: String? = nil,
                     semantic: UISemanticContentAttribute = .forceLeftToRight) {
        self.init(frame: .zero)
        if let imageName = imageName {
            self.setImage(UIImage(named: imageName), for: .normal)
            self.semanticContentAttribute = semantic
            let offset: CGFloat = (self.semanticContentAttribute == .forceLeftToRight) ? 8.0 : -8.0
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: offset)
        }
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = Configuration.Theme.main
        self.layer.cornerRadius = Configuration.UI.cornerRadius
    }
}
