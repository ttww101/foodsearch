import Foundation
final class LLProductModel: Decodable {
    var code: Int
    var message: String
    var shopId: String
    var prodShopId: String
    var datacnt: Int
    var imgpath: String
    var appcateImgpath: String?
    var product: [LLProduct]
}
final class LLProduct: Decodable {
    var prodId: String
    var prodName1: String?
    var prodName2: String?
    var price1: String?
    var price2: String?
    var imgfile1: String?
    var appCate: [LLProductCategory]?
}
final class LLProductCategory: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id         = "serno"
        case title      = "subject"
        case imgfile1   = "imgfile1"
        case imgfile2   = "imgfile2"
    }
    var id      : String
    var title   : String
    var imgfile1: String?
    var imgfile2: String?
}
