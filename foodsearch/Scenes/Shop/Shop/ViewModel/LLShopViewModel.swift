import Bond
import Aletheia
import Foundation
import ReactiveKit
final class LLShopViewModel {
    private var productModel: LLProductModel?
    private var categoryModel: LLProductCategoryModel?
    var series: [LLSeries] = []
    let seriesSignal = Observable<[LLSeries]?>(nil)
    init(shop: LLShop) {
        LLShopManager.share.set(with: shop)
    }
    func makeRequest() {
        requestProductCategoryAPI()
        requestProductAPI()
        self.mappingCategoryAndProduct()
    
    }
    func getCheckoutContext(price: UInt) -> String {
        return "(加入我的最愛 $ \(price))"
    }
    func getProductsBy(categoryId: String) -> LLSeries? {
        return series.first { $0.categoryID == categoryId }
    }
    func isShowSelectedView() -> Bool {
        if LLShopManager.share.hasSelectTime() {
            return false
        }
        return true
    }
    func getTitle() -> String {
        return LLShopManager.share.title
    }
    func getImageURL() -> String {
        return LLShopManager.share.imageFile
    }
    private func requestProductAPI() {
        LLProductClient()
            .start { (response) in

                guard let data = response.value as? Data else { return }
                if let object = self.parseJSON(data: data) {
                    self.productModel = object
                }
        }
    }
    private func requestProductCategoryAPI() {
        LLProductCategoryClient()
            .start {(response) in
                guard let data = response.value as? Data else { return }
                if let object = self.parseCategoryJSON(data: data) {
                    self.categoryModel = object
                }
        }
    }
    private func mappingCategoryAndProduct() {
        let products    = productModel?.product
        for category in categoryModel?.data ?? [] {
            let value           = LLSeries()
            value.categoryID    = category.serno
            value.categoryName  = category.subject
            value.imgpath       = categoryModel?.imgpath ?? ""
            series.append(value)
        }
        for product in products ?? [] {
            if let appCategories = product.appCate {
                let categoryIds = appCategories.map { return $0.id }
                for element in series {
                    if categoryIds.contains(element.categoryID) {
                        element.products.append(product)
                    }
                }
            }
        }
        seriesSignal.value = series.filter { (data) -> Bool in
            return !data.products.isEmpty
        }
    }
}
extension LLShopViewModel {
    func parseJSON(data: Data) -> LLProductModel? {
        return data.al.jsonType(type: LLProductModel.self)
    }
    func parseCategoryJSON(data: Data) -> LLProductCategoryModel? {
        return data.al.jsonType(type: LLProductCategoryModel.self)
    }
}
