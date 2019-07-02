import Bond
import ReplayKit
import Foundation
struct LLItems {
    let product: LLProduct
    let amount: UInt
}
final public class LLShopManager {
    static let share = LLShopManager()
    private init() {}
    private(set) var id: String = "0457"
    private(set) var auth: String = "sff2gry11t5jkwy1jwq6das6lf6n2fz5"
    private(set) var title: String = ""
    private(set) var date: String?
    private(set) var imageFile: String = ""
    let totalPrice = Observable<UInt>(0)
    private(set) var items: [LLItems] = []
    func set(with shop: LLShop) {
        title           = shop.shopName
        imageFile       = shop.imgfile1 ?? ""
    }
    func set(with date: String) {
        self.date = date
    }
    func isEmpty() -> Bool {
        return items.count == 0 ? true : false
    }
    func hasSelectTime() -> Bool {
        return date == nil ? false : true
    }
    func addProductItems(product: LLProduct,
                         amount: UInt) {
        guard let value = product.price1 else { return }
        guard let priceString = value.al.withoutDecimal() else { return }
        guard let price = Int(priceString) else { return }
        let newItem = LLItems(product: product, amount: amount)
        self.totalPrice.value += (UInt(price) * amount)
        self.items.append(newItem)
    }
    func reset() {
        items.removeAll()
    }
}
