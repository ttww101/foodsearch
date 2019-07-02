import Aletheia
import Alamofire
final class LLProductClient {
    func start(completion: @escaping Response) {
        let url = Bundle.main.url(forResource: "productsdetail", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        completion(Result.success(data))
    }
}
