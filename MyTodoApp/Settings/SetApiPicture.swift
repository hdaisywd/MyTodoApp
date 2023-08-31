
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
}

