
import Foundation
import UIKit
import FSCalendar

extension HomeVC: FSCalendarDelegate, FSCalendarDataSource {
    
    /* 오늘의 날짜를 불러온다 */
    /* 예외 처리 해주는거 질문하기 */
    func getDate() -> [Int] {
        let today = Date().formatted().components(separatedBy: " ")[0].components(separatedBy: "/")
        let month = Int(today[0]) ?? 1998
        let date = Int(today[1]) ?? 5
        let year = Int(today[2]) ?? 8
        
        print(today)
        return [year, month, date]
    }
    
    /* 캘린더를 불러온다 */
    func setCalendar(year: Int, month: Int, date: Int) {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.locale = Locale(identifier: "kr_KR")
        
        /* CalendarView Rounded Edges */
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 10.0
        
        /* 캘린더 색 정하기 */
        calendarView.appearance.headerTitleColor = UIColor.systemTeal
        calendarView.appearance.weekdayTextColor = UIColor.systemTeal
        calendarView.appearance.selectionColor = UIColor.systemTeal
        calendarView.appearance.titleDefaultColor = UIColor.systemTeal
        
        
        /* view에 추가하기 */
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calendarView.heightAnchor.constraint(equalToConstant: 500),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
//        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
//        calendarView.selectionBehavior = dateSelection
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

    /* 달력에서 날짜 선택 처리 */
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        
        /* Date Detail 페이지 불러오기 */
        let dateDetailVC = DateDetailVC(selectedDate)
        dateDetailVC.modalPresentationStyle = .pageSheet
        
        self.present(dateDetailVC, animated: true)
        
        reloadCalendarView(date: Calendar.current.date(from: dateComponents!))
        
        /* 한 날짜를 여러번 선택 가능하게 해주는 코드 */
        selection.setSelected(nil, animated: false)
    }
    
    /* 날짜 선택 후 reload */
    func reloadCalendarView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
//        calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}
