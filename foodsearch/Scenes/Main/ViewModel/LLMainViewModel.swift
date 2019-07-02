import Bond
import Aletheia
import Foundation
import ReactiveKit
final class LLMainViewModel {
    let banners = MutableObservableArray<String>()
    let contents = MutableObservableArray<LLShopModel?>()
    private var temp = Array<LLShopModel>([])
    init() { }
    func requestAPI(completion: @escaping (_ any: Any?) -> ()) {
        LLCommercialClient().start { (response) in
            guard let data = response.value as? Data else {
                completion(APIError(code: nil, message: response.error?.localizedDescription))
                return
            }
            if let object = self.parseJSON(data: data) {
                for element in object.data {
                    self.requestGetShopAPI(id: element.id)
                }
                self.contents.insert(contentsOf: self.temp, at: 0)
            } 
        }
    }
    func requestGetShopAPI(id: String) {
        _ = LLGetShopClient(commercialID: id) { (response) in
            if let data = response.value as? Data {
                if let object = self.parseShopJSON(data: data) {
                    self.temp.append(object)
                }
            }
        }
    }
}
extension LLMainViewModel {
    func parseJSON(data: Data) -> LLCommercialModel? {
        return data.al.jsonType(type: LLCommercialModel.self)
    }
    func parseShopJSON(data: Data) -> LLShopModel? {
        return data.al.jsonType(type: LLShopModel.self)
    }
    func parseBannerJSON(data: Data) -> LLBannerModel? {
        return data.al.jsonType(type: LLBannerModel.self)
    }
}




