
import Foundation
import UIKit
import FSCalendar

class HomeVC: UIViewController, MyCalendarViewDelegate {

    /* 달력 */
    let calendarView = MyCalendarView() 
    var selectedDate: DateComponents? = nil
    var hasSchedule = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        /* Title View */
        setHomeTitle()
        getCalendar()
    }
    
    /* navigation Bar 설정 */
    func setHomeTitle() {
        self.navigationItem.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(addBarButtonAction))
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    /* add Task 화면과 연결 */
    @objc func addBarButtonAction() {
        present(NewTaskVC(), animated: true)
    }
    
    /* 캘린더를 불러온다 */
    func getCalendar() {
        calendarView.myDelegate = self 
        
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calendarView.heightAnchor.constraint(equalToConstant: 500),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    func didSelectDate(year: Int, month: Int, day: Int) {
        print("눌렸습니다")
        present(DateDetailVC(year, month, day), animated: true)
    }

}
