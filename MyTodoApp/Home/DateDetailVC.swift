
import Foundation
import UIKit

class DateDetailVC: UIViewController {
    /* 선택된 날짜 */
    let year: Int?
    let month: Int?
    let day: Int?
    
    /* tableView */
    let myTableView = UITableView()
    let dateLabel = UILabel()
    var items = [Task]()
    
    let monthInEnglish = [ "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec" ]
    
    /* 초기화 */
    init(_ dateComponents: DateComponents?) {
        self.year = dateComponents?.year
        self.month = dateComponents?.month
        self.day = dateComponents?.day
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setDateLabel()
        
        loadDateData{ self.setTableView() }
    }

}
