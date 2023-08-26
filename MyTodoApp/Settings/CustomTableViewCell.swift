//
//  CustomTableViewCell.swift
//  MyTodoApp
//
//  Created by Daisy Hong on 2023/08/26.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

    static let cellId = "CellId"

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
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        name.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        name.widthAnchor.constraint(equalToConstant: 60).isActive = true
        name.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
}
