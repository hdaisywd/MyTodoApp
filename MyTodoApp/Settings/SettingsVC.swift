
import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    /* User Profile */
    var userProfileView = UIView()
    var userProfileStackView = UIStackView()
    var alarmIcon = UIImageView()
    var nickNameLabel = UILabel()
    var profilePictureView = UIImageView()
    public var profilePicture: UIImage?
    public var nickName: String?
    
    /* Set Items View */
    var itemsView = UIView()
    let oneLabelHeight = 40
    
    /* NickName Change */
    var nickNameChangeButton = UIButton()
    var nickNameChangeLabel = UILabel()
    
    /* Dark/Light Mode */
    var darkLightModeChangeButton = UIButton()
    var darkLightModeChangeLabel = UILabel()
    
    /* AppLock */
    var appLockButton = UIButton()
    var appLockLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /* NavigationBar Title */
        self.navigationItem.title = "Settings"
        
        /* User Profile */
        setUserProfile()
        setItemsView()
    }

}
