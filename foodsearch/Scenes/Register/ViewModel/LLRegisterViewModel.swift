import Bond
import Aletheia
import Foundation
import ReactiveKit
final class LLRegisterViewModel {
    let name = Observable<String?>(nil)
    let isFemale = Observable<Bool>(true)
    let birthday = Observable<String?>("1970-01-01")
    let email = Observable<String?>(nil)
    let password = Observable<String?>(nil)
    let passwordConfirm = Observable<String?>(nil)
    let phone = Observable<String?>(nil)
    init() {}
    func requestAPI(completion: @escaping (_ any: Any?) -> ()) {
        guard let name     = name.value else { return }
        guard let email    = email.value else { return }
        guard let password = password.value else { return }
        guard let phone    = phone.value else { return }
        guard let birthday    = birthday.value else { return }
        LLRegisterClient(name: name, sex: getGenderToRequestFormat(), email: email, phone: phone, birthday: birthday, password: password).start { (response) in
            if let data = response.value as? Data {
                if let object = self.parseJSON(data: data), object.code == 0 {
                    completion(object)
                } 
            }
        }
    }
    func getNameFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: "icon_star", title: "姓名", placeholder: "請輸入姓名", returnType: .done)
    }
    private func getGenderToRequestFormat() -> String {
        return isFemale.value == true ? "1" : "0"
    }
    func getPasswordFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: "icon_star", title: "密碼", placeholder: "請輸入密碼，至少6位", returnType: .next)
    }
    func getPasswordConfirmFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: "icon_star", title: "確認密碼", placeholder: "請輸入確認密碼", returnType: .next)
    }
    func getPhoneFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: "icon_star", title: "手機", placeholder: "請輸入手機號碼", returnType: .done)
    }
    func getEmailFormModel() -> LLLoginFormModel {
        return LLLoginFormModel(imageName: nil, title: "信箱", placeholder: "請輸入信箱", returnType: .next)
    }
    func isPasswordConfrimSame() -> Bool {
        return (password.value == passwordConfirm.value) ? true : false
    }
    func isPasswordOverSixCharacter() -> Bool {
        if let amount = password.value?.count, amount >= 6 {
            return true
        }
        return false
    }
    func isRightEmailFormat(with sender: String?) -> Bool {
        if let email = sender, email.al.isValidEmail() {
            return true
        }
        return false
    }
    func isDoneFillup() -> Bool {
        if self.name.value?.isEmpty ?? true ||
            self.birthday.value?.isEmpty ?? true ||
            self.email.value?.isEmpty ?? true ||
            self.password.value?.isEmpty ?? true ||
            self.passwordConfirm.value?.isEmpty ?? true ||
            self.phone.value?.isEmpty ?? true {
            return false
        }
        return true
    }
    func convert(from: Date) -> String {
        return from.al.stringType(format: "yyyy-MM-dd")
    }
}
extension LLRegisterViewModel {
    func parseJSON(data: Data) -> LLUserManager.Infos? {
        return data.al.jsonType(type: LLUserManager.Infos.self)
    }
}
