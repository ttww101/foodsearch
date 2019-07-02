import Foundation
typealias LLSubtotals = (key: String, value: String)
final class LLCartViewModel {
    init() {
    }
    func getTotalPriceContext() -> String {
        return "結帳（總金額 $\(LLShopManager.share.totalPrice.value)）"
    }
    func getSubtotals() -> [LLSubtotals] {
        return [
            ("小計 $", "\(LLShopManager.share.totalPrice.value)"),
            ("折扣 $", "0"),
            ("票卷折抵 $", "0")
        ]
    }
}
