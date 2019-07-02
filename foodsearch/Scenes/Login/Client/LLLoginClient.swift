import Foundation
import Aletheia
import Alamofire
final class LLLoginClient: Networkable {
    var parameters: [String : Any]? {
        var  _parameters = ["op": "login",
                            "sId": self.account,
                            "password": self.password] as [String : Any]
        _parameters += Configuration.API.authKey
        return _parameters
    }
    var method: HTTPMethod = .post
    var baseURL: String = Configuration.API.member
    var networkClient: NetworkClient = NetworkClient()
    private var account: String
    private var password: String
    init(account: String, password: String) {
        self.account = account
        self.password = password
    }
    func start(completion: @escaping Response) {
        self.networkClient.performRequest(self) { (response) in
            completion(response)
        }
    }
}
