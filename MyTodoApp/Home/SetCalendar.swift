
import Foundation
import UIKit
import FSCalendar

extension HomeVC: FSCalendarDelegate, FSCalendarDataSource {
    
    /* 캘린더를 불러온다 */
    func setCalendar() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        /* CalendarView Rounded Edges */
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 10.0
        
        /* 캘린더 색 정하기 */
        calendarView.appearance.headerTitleColor = UIColor.systemTeal
        calendarView.appearance.weekdayTextColor = UIColor.systemTeal
        calendarView.appearance.selectionColor = UIColor.systemBlue
        calendarView.appearance.titleDefaultColor = UIColor.systemTeal
        calendarView.appearance.todayColor = UIColor.systemTeal
        
        /* view에 추가하기 */
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calendarView.heightAnchor.constraint(equalToConstant: 500),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("date select function", date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "kr_KR")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        let formattedDate = dateFormatter.string(from: date)
        
        /* 강제 언래핑 하지 말라고요 */
        let dates = formattedDate.split(separator: "-").map{Int($0)!}
        let year = dates[0]
        let month = dates[1]
        let day = dates[2]
        
        print("formatted Date: ", year, month, day)
        
        present(DateDetailVC(year, month, day), animated: true)
    }
    
    /* 선택된 날짜들에 라벨 붙이기 */
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        var dates = [[Int]]()
        
        taskManager.readAllTasks { tasks in
            for task in tasks {
                dates.append([task.dueDateDay, task.dueDateMonth, task.dueDateYear])
            }
        }
        
//        for date in dates {
//            if let dueDate = createDateFromComponents(year: date[0], month: date[1], day: date[2]),
//               Calendar.current.isDate(dueDate, equalTo: dateComponents.date!, toGranularity: .day) {
//                return .customView {
//                    let label = UILabel()
//                    label.text = "🐯"
//                    label.textAlignment = .center
//                    return label
//                }
//            }
//        }
        
        return nil
    }

}
