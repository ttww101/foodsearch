import UIKit
import SnapKit
import JTAppleCalendar
final class LLCalendarHeaderView: JTAppleCollectionReusableView {
    public let monthTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = Configuration.Font.normal
        lbl.textAlignment = .center
        return lbl
    }()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        self.addSubview(monthTitle)
        monthTitle.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
