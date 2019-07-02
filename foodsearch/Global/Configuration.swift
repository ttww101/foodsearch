import Aletheia
import Foundation
let isDebug: Bool = false
enum Configuration {
    enum Storage {
        static let sourceDirectoryPath = "FoodSearchSource/"
    }
    enum Theme {
        static let main = UIColor(red:1.00, green:0.65, blue:0.00, alpha:1.0)
        static let navigationTitleColor = UIColor.black
        static let subtitle = UIColor.gray
    }
    enum Font {
        static let normal = UIFont.systemFont(ofSize: 17.0)
        static let system = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        static let support = UIFont.systemFont(ofSize: 14.0)
    }
    enum UI {
        static let cornerRadius: CGFloat = 6.0
    }
}
extension Configuration {
    enum API {
        static let domain = ""
        static let member           = Configuration.API.domain
        static let product          = Configuration.API.domain
        static let basic            = Configuration.API.domain
        static var authKey = ["authkey": "ajsndlnasdalsd"]
    }
}
extension Configuration {
    enum Key {
        static let user = "Configuration.Key.user"
        static let bundle = ALSystems.appBundleIdentifier
    }
}
extension Configuration {
    enum Context {
        static let order = "喜愛列表"
        static let checkout = "結帳"
        static let cart = "購物車"
        static let add2Cart = "加入購物車"
        static let leave = "是否確定離開此商店，離開將會清空您的購物車"
        static let back2Main = "回首頁"
        static let cancel = "取消"
        static let title = "標題"
        static let next = "下一步"
        static let confirm = "確定"
        static let orderOnce = "一次僅可從一家餐廳訂購餐點"
        static let verificationCode = "傳送驗證碼"
        static let transactionSuccess = "交易成功"
        static let noData = "沒有資料"
        static let noProductData = "沒有商品資料"
        static let wrongEmailFormat = "請輸入正確的 email 格式"
        static let passwordNotSame = "兩次密碼輸入不同"
        static let passwordWrongLenght = "請輸入 6 位字以上"
        static let wayDeliveries = "取餐方式"
        static let wayPayments = "付款方式"
        static let checkOrderStatus = "交易成功\n您可以從購買紀錄\n查詢記單狀態"
        static let enterShop = "請輸入商店名稱"
        static let enterPhone = "請輸入手機號碼"
        static let enterCode = "請輸入驗證碼"
        static let enterComplete = "請輸入完整格式"
        static let selectTitle = "請選擇取餐日期及時間"
        static let selectSubtitle = "為避免您選購到無法供餐之商品\n請先進行取餐時間設定"
        static let selectDate = "取餐日期"
        static let selectTime = "取餐時間"
        static let installLine = "請安裝 Line App 來完成付款"
    }
}
