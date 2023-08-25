
import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    let checkbox = UIImageView()
    let task = UILabel()
    let pin = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(checkbox)
        self.addSubview(task)
        self.addSubview(pin)
        
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            checkbox.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
