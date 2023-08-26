
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
    
    /* NickName Change */
    var nickNameChangeStr = "Change nickname"
    
    /* Dark/Light Mode */
    var darkLightModeChangeStr = "Dark mode / Light mode"
    
    /* AppLock */
    var appLockStr = "Lock app"
    
    /* Set Items Table View */
    var itemsView = UITableView()
    lazy var items = [ nickNameChangeStr, darkLightModeChangeStr, appLockStr ] // 최초 접근시 할당하도록
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /* NavigationBar Title */
        self.navigationItem.title = "Settings"
        
        /* User Profile */
        setUserProfile()
        setItemsTableView()
    }

}
