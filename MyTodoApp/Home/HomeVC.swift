
import Foundation
import UIKit

class HomeVC: UIViewController {
    /* 달력 */
    let calendarView = UICalendarView()
    var selectedDate: DateComponents? = nil
    var hasSchedule = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        /* 달력 */
        let today = getDate()
        getCalendar(year: today[0], month: today[1], date: today[2])
    }


}
