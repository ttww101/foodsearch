import Foundation
struct LLShopModel: Decodable {
    var code: Int
    var message: String
    var datacnt: Int
    var name: String
    var data: [LLShop]
    private enum CodingKeys: String, CodingKey {
        case name = "commercialDistrictName"
        case code
        case message
        case datacnt
        case data
    }
}
struct LLShop: Decodable {
    var shopName: String
    var imgfile1: String?
}
