import Aletheia
import Alamofire
final class LLCommercialClient {
    init() {}
    func start(completion: @escaping Response) {
        let url = Bundle.main.url(forResource: "commercial", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        completion(Result.success(data))
    }
}
