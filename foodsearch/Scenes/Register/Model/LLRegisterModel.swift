import UIKit
final class LLRegisterModel: Decodable {
    var name: String?
    var sex: String?
    var birthday: String?
    var email: String?
    var mobile: String?
    var code: Int = 0
    var message: String?
}
struct LLLoginFormModel {
    var imageName: String?
    var title: String
    var placeholder: String
    var returnType: UIReturnKeyType
}
