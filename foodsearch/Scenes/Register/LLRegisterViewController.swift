import UIKit
import SnapKit
import Aletheia
import ReactiveKit
extension LLRegisterViewController: LLHeaderViewProtocol {}
extension LLRegisterViewController: Loadable {}
final class LLRegisterViewController: LLViewController {
    private let viewModel = LLRegisterViewModel()
    private let width = ALScreen.width * 0.8
    private let formViewHeight: CGFloat = 60.0
    private lazy var updateConstraintsBase = -(formViewHeight + offset)
    private lazy var scrollView: LLScrollView = {
        let sv = LLScrollView()
        sv.delegate = self
        return sv
    }()
    private lazy var nameView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getNameFormModel())
    }()
    private lazy var emailView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getEmailFormModel())
    }()
    private let iconCalendar: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "icon_calendar"))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    private lazy var passwordView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getPasswordFormModel())
    }()
    private lazy var passwordConfirmView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getPasswordConfirmFormModel())
    }()
    private lazy var phoneView: LLLoginFormView = {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: formViewHeight))
        return LLLoginFormView(frame: frame, data: viewModel.getPhoneFormModel())
    }()
    private let confirmButton: LLButton = {
        return LLButton(title: "下一步", imageName: "icon_next", semantic: .forceRightToLeft)
    }()
    private let btnCalendar: UIButton = {
        let btn = UIButton()
        btn.setTitle("YYYY/MM/DD", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 2.0
        return btn
    }()
    private let lblGender: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "性別"
        lbl.textAlignment = .left
        return lbl
    }()
    private let iconBirthday: UIImageView = {
        return UIImageView(image: UIImage(named: "icon_star1"))
    }()
    private let iconGender: UIImageView = {
        return UIImageView(image: UIImage(named: "icon_star"))
    }()
    private lazy var genderButtonWidth: CGFloat = {
        return (width - CGFloat(offset)) / 2
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "加入會員"
        setupViews()
        setupEvents()
        setupBindings()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.updateContentView()
    }
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        let headerView = getHeaderView(CGRect(x: 0, y: 0, width: ALScreen.width, height: ALScreen.width * 3 / 4), title: "資料填寫", imageName: "member_header")
        scrollView.addSubview(headerView)
        scrollView.addSubview(nameView)
        nameView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        scrollView.addSubview(emailView)
        emailView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        scrollView.addSubview(passwordView)
        passwordView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        scrollView.addSubview(passwordConfirmView)
        passwordConfirmView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        scrollView.addSubview(phoneView)
        phoneView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordConfirmView.snp.bottom).offset(offset)
            make.width.equalTo(width)
            make.height.equalTo(74.0)
        }
        scrollView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneView.snp.bottom).offset(offset * 2)
            make.width.equalTo(width)
            make.height.equalTo(44.0)
        }
    }
    private func setupEvents() {
        nameView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase)
        }
        nameView.finishEditing { [weak self] text in
            guard let self = self else { return }
            self.viewModel.name.value = text
            self.scrollView.updateConstraints(offset: 0.0)
        }
        emailView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase * 5)
        }
        emailView.finishEditing { [weak self] text in
            guard let self = self else { return }
            if self.viewModel.isRightEmailFormat(with: text) {
                self.viewModel.email.value = text
                self.passwordView.textfield.becomeFirstResponder()
            } else {
                self.setupAlertView(Configuration.Context.wrongEmailFormat,
                                    message: "",
                                    confirm: Configuration.Context.confirm)
            }
        }
        passwordView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase * 6)
        }
        passwordView.finishEditing { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.isPasswordOverSixCharacter() {
                self.passwordConfirmView.textfield.becomeFirstResponder()
            } else {
                self.setupAlertView(Configuration.Context.passwordWrongLenght,
                                    message: "",
                                    confirm: Configuration.Context.confirm)
            }
        }
        passwordConfirmView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase * 7)
        }
        passwordConfirmView.finishEditing { [weak self] text in
            guard let self = self else { return }
            if self.viewModel.isPasswordConfrimSame() {
                self.viewModel.password.value = text
                self.phoneView.textfield.becomeFirstResponder()
            } else {
                self.setupAlertView(Configuration.Context.passwordNotSame,
                                    message: "",
                                    confirm: Configuration.Context.confirm)
            }
        }
        phoneView.beginEditing { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateConstraints(offset: self.updateConstraintsBase * 8)
        }
        phoneView.finishEditing { [weak self] text in
            guard let self = self else { return }
            self.prepareToMakeRequest()
            self.viewModel.phone.value = text
        }
        _ = confirmButton.reactive.controlEvents(.touchUpInside)
            .observeNext { [weak self] _ in
                guard let self = self else { return }
                self.prepareToMakeRequest()
        }
    }
    private func setupBindings() {
        viewModel.name
            .bidirectionalBind(to: nameView.textfield.reactive.text)
        viewModel.email
            .bidirectionalBind(to: emailView.textfield.reactive.text)
        viewModel.password
            .bidirectionalBind(to: passwordView.textfield.reactive.text)
        viewModel.passwordConfirm
            .bidirectionalBind(to: passwordConfirmView.textfield.reactive.text)
        viewModel.phone
            .bidirectionalBind(to: phoneView.textfield.reactive.text)
    }
    private func prepareToMakeRequest() {
        if viewModel.isDoneFillup() {
            scrollView.updateConstraints(offset: 0.0)
            startLoading(at: view.center, onTopOf: view)
            makeRequest()
        } else {
            setupAlertView(Configuration.Context.title,
                            message: Configuration.Context.enterComplete,
                            confirm: Configuration.Context.confirm)
        }
    }
    private func makeRequest() -> Void {
        viewModel.requestAPI() { [weak self] (response) in
            self?.stopLoading()
            guard let self = self else { return }
            if let user = response as? LLUserManager.Infos {
                LLUserManager.share.login(value: user)
            }
            if let error = response as? APIError {
                self.setupAlertView(Configuration.Context.title,
                                    message: error.message ?? "",
                                    confirm: Configuration.Context.confirm)
            }
        }
    }
}
extension LLRegisterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}
extension LLRegisterViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isEditing {
            self.scrollView.updateConstraints(offset: 0.0)
            self.view.endEditing(true)
        }
    }
}
