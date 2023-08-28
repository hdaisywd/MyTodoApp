
import Foundation
import UIKit

class CustomDetailViewCell: UITableViewCell {
    
    let checkbox = UIButton()
    let task = UILabel()
    let starred = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStarred()
        setCheckBox()
        cellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellLayout() {
        self.addSubview(starred)
        self.addSubview(checkbox)
        self.addSubview(task)
        
        starred.translatesAutoresizingMaskIntoConstraints = false
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        task.translatesAutoresizingMaskIntoConstraints = false
        
        starred.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        starred.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        checkbox.leadingAnchor.constraint(equalTo: starred.trailingAnchor, constant: 10).isActive = true
        checkbox.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        task.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 10).isActive = true
        task.centerYAnchor.constraint(equalTo: checkbox.centerYAnchor).isActive = true
    }
    
    func setCheckBox() {
        checkbox.setImage(UIImage(systemName: "circle")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), for: .normal)
        checkbox.addTarget(self, action: #selector(checkboxAction), for: .touchUpInside)
    }
    
    func setStarred() {
        starred.image = UIImage(systemName: "star.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    }
    
    /* 연결된 db로 체크 정보 보내주기 */
    @objc func checkboxAction() {
        
    }
}
