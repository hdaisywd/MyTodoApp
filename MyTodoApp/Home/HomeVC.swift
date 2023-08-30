
import Foundation
import UIKit
import FSCalendar

class HomeVC: UIViewController {
    /* 달력 */
    let calendarView = FSCalendar() 
    var selectedDate: DateComponents? = nil
    var hasSchedule = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        /* Title View */
        setHomeTitle()
        
        /* 달력 */
        let today = getDate()
        setCalendar(year: today[0], month: today[1], date: today[2])
    }
    
    /* navigation Bar 설정 */
    func setHomeTitle() {
        self.navigationItem.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(addBarButtonAction))
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    /* add Task 화면과 연결 */
    @objc func addBarButtonAction() {
        present(AddTaskVC(), animated: true)
    }


}
