import UIKit
import Kingfisher
public final class LLImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init() {
        self.init(frame: .zero)
        self.contentMode = .scaleToFill
        self.clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func load(with aURL: String?, placeholder: String = "icon_logo") {
        
        self.image = UIImage(named: aURL ?? "placeholderImage")
        
        

    }
}
