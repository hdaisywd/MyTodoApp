
import Foundation
import UIKit

extension SettingsVC {
    
    func setItemsView() {
        view.addSubview(itemsView)
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        
        itemsView.backgroundColor = .red

        NSLayoutConstraint.activate([
            itemsView.trailingAnchor.constraint(equalTo: userProfileView.trailingAnchor),
            itemsView.leadingAnchor.constraint(equalTo: userProfileView.leadingAnchor),
            itemsView.topAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: 10),
            itemsView.heightAnchor.constraint(equalToConstant: CGFloat(oneLabelHeight * 3 + 30))
        ])
    }

    func setNickNameChange() {
        nickNameChangeLabel.text = "Change nickname"
        nickNameChangeLabel.textAlignment = .center
        nickNameChangeLabel.font = .boldSystemFont(ofSize: 25)
        nickNameChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nickNameChangeLabel)
        
        NSLayoutConstraint.activate([
            nickNameChangeLabel.trailingAnchor.constraint(equalTo: userProfileStackView.trailingAnchor),
            nickNameChangeLabel.leadingAnchor.constraint(equalTo: userProfileStackView.leadingAnchor),
            nickNameChangeLabel.topAnchor.constraint(equalTo: userProfileStackView.bottomAnchor, constant: 10)
        ])
    }
}
