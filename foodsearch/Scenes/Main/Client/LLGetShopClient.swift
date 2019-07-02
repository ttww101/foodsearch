import Aletheia
import Alamofire
final class LLGetShopClient {

    init(commercialID: String, completion: @escaping Response) {
        if let url = Bundle.main.url(forResource: commercialID, withExtension: "json") {
            let data = try! Data(contentsOf: url)
            completion(Result.success(data))
        }
        completion(Result.success(nil))
    }
}
