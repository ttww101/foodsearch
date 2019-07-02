import Bond
import Aletheia
import Foundation
import ReactiveKit
final class LLLoginViewModel {
    let account = Observable<String?>(nil)
    let password = Observable<String?>(nil)
    init() {}
    func requestAPI(completion: @escaping (_ any: Any?) -> ()) {
        LLLoginClient(account: account.value!, password: password.value!).start { (response) in
            if let data = response.value as? Data {
                if let object = self.parseJSON(data: data) {
                    completion(object)
                }
            } 
        }
    }
    func isEmpty() -> Bool {
        if self.account.value?.isEmpty ?? true ||
            self.password.value?.isEmpty ?? true {
            return true
        }
        return false
    }
}
extension LLLoginViewModel {
    func parseJSON(data: Data) -> LLUserManager.Infos? {
        return data.al.jsonType(type: LLUserManager.Infos.self)
    }
}
