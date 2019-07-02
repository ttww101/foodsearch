import UIKit
import Aletheia
final class LLCalendarViewController: UIViewController {
    private let viewModel: LLCalendarViewModel = {
        return LLCalendarViewModel()
    }()
    public var onFinish: ((_ date: Date) -> ())?
    private let btnConfirm: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle(Configuration.Context.confirm, for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        return b
    }()
    private let btnCancel: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle(Configuration.Context.cancel, for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        return b
    }()
    private let width: CGFloat = {
        return ALScreen.width * 0.9
    }()
    private let bg: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = Configuration.UI.cornerRadius
        v.clipsToBounds = true
        return v
    }()
    private let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.backgroundColor = Configuration.Theme.main
        return lbl
    }()
    private lazy var calendarView: LLCalendarView = {
        return LLCalendarView(startDate: startDate, endDate: endDate)
    }()
    private let startDate: Date
    private let endDate: Date
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        let v = UIView(frame: UIScreen.main.bounds)
        v.backgroundColor = .clear
        self.view = v
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupEvents()
    }
}
extension LLCalendarViewController {
    private func setupViews() {
        view.addSubview(bg)
        bg.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(width + 88.0)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        bg.addSubview(calendarView)
        calendarView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(width)
        }
        bg.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (make) in
            make.width.top.centerX.equalToSuperview()
            make.height.equalTo(44.0)
        }
        bg.addSubview(btnConfirm)
        btnConfirm.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8.0)
            make.width.height.equalTo(44.0)
            make.bottom.equalToSuperview()
        }
        bg.addSubview(btnCancel)
        btnCancel.snp.makeConstraints { (make) in
            make.right.equalTo(btnConfirm.snp.left).offset(-8.0)
            make.width.height.equalTo(44.0)
            make.bottom.equalToSuperview()
        }
    }
    private func setupEvents() {
        _ = btnConfirm.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] in
            guard let self = self else { return }
            self.onFinish?(self.viewModel.date.value)
            self.dismiss(animated: false, completion: nil)
        }
        _ = btnCancel.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: false, completion: nil)
        }
        calendarView.actionClick = { [weak self] date in
            guard let self = self else { return }
            self.viewModel.date.value = date
        }
        _ = viewModel.date.observeNext { [weak self] date in
            guard let self = self else { return }
            self.lblTitle.text = self.viewModel.convert(from: date)
        }
    }
}
