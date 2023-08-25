//
//  SettingsVC.swift
//  MyTodoApp
//
//  Created by Daisy Hong on 2023/08/23.
//

import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    /* User Profile */
    var stackView = UIStackView()
    var alarmIcon = UIImageView()
    var nickNameLabel = UILabel()
    var profilePictureView = UIImageView()
    public var profilePicture: UIImage?
    public var nickName: String?
    
    /* NickName Change */
    var nickNameChangeButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /* User Profile */
        setUserProfile()
    }

}
