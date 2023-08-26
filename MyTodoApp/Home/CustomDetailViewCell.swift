
import Foundation
import UIKit

class CustomDetailViewCell: UITableViewCell {
    
    let checkbox = UIButton()
    let task = UILabel()
    let pin = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkbox.setImage(UIImage(systemName: "rectangle"), for: .normal)
        pin.setImage(UIImage(systemName: "pin"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(pin)
        self.addSubview(checkbox)
        self.addSubview(task)
        
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            checkbox.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
