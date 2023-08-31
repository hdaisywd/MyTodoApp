
import Foundation
import Alamofire
import RxSwift

class ApiManager {
    func makeRequest() {
        AF.request("https://api.thecatapi.com/v1/images/search").response {
            response in debugPrint(response)
        }
    }
}
