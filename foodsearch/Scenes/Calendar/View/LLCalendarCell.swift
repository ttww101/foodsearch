import UIKit
import SnapKit
import JTAppleCalendar
final class LLCalendarCell: JTAppleCell {
    let context: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    let selectedView: UIView = {
        let v = UIView()
        v.backgroundColor = Configuration.Theme.main
        return v
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {        
        contentView.addSubview(selectedView)
        selectedView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        contentView.addSubview(context)
        context.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
