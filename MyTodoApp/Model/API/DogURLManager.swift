
import Foundation
import Alamofire

class DogURLManager {
    static let shared = DogURLManager()
    let url = URL(string: "https://api.thedogapi.com/v1/images/search")!
    
    private init() { }
    
    func getJsonData(path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url.appending(path: path))
        { data, response, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(NetworkError.unknown(error.localizedDescription)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error: invalid response")
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("Error: no data")
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case unknown(String)
    case invalidResponse
    case emptyResponse
}
