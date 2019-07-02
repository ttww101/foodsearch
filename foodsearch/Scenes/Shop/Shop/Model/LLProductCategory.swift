import Foundation
final class LLProductCategoryModel: Decodable {
    var code: Int
    var message: String
    var datacnt: Int
    var prodModel: String?
    var imgpath: String?
    var data: [LLCategory]
}
final class LLCategory: Decodable {
    var serno: String
    var subject: String
    var imgfile1: String?
    var imgfile2: String?
    var istag: String?
    var ishome: String?
}
