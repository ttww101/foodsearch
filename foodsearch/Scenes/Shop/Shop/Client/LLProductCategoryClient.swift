import Aletheia
import Alamofire
final class LLProductCategoryClient {

    func start(completion: @escaping Response) {
        let url = Bundle.main.url(forResource: "products", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        completion(Result.success(data))
        
    }
}
