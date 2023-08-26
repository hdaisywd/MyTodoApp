
import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

    static let cellId = "cellIdentifier"

    var name = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellLayout() {
        self.addSubview(name)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 20)
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        name.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
}
