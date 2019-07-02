import Foundation
struct LLBannerModel: Decodable {
    var code: Int
    var message: String?
    var datacnt: Int
    var imgpath: String?
    var data: [BannerDetail]
}
struct BannerDetail: Decodable {
    var bannerid: String?
    var subject: String?
    var url: String?
    var imgfile1: String?
}
