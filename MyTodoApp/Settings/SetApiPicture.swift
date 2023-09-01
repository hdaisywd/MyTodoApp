
import Foundation
import UIKit

extension SettingsVC {
    
    func setApiPicture() {
        apiPicture.image = UIImage(named: "WonduPictureSoCute")
        apiPicture.contentMode = .scaleAspectFit
        
        apiPicture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(apiPicture)
        
        NSLayoutConstraint.activate([
            apiPicture.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor),
            apiPicture.trailingAnchor.constraint(equalTo: itemsView.trailingAnchor),
            apiPicture.topAnchor.constraint(equalTo: itemsView.bottomAnchor, constant: 10),
            apiPicture.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func getURLData() {
        dogURLManager.getJsonData(path: "") { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    if let imageURLString = response?.first?["url"] as? String, let imageURL = URL(string: imageURLString) {
                        DispatchQueue.global().async {
                            if let imageData = try? Data(contentsOf: imageURL),
                               let image = UIImage(data: imageData) {
                                DispatchQueue.main.async {
                                    self.apiPicture.image = image
                                }
                            }
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
