
import Foundation
import UIKit
import FSCalendar

extension HomeVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    /* 캘린더를 불러온다 */
    func setCalendar() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        /* CalendarView Rounded Edges */
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 10.0
        
        /* 월요일부터 시작 */
        calendarView.firstWeekday = 2
        
        /* Header */
        calendarView.appearance.headerDateFormat = "YYYY / MM"
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        
        /* 캘린더 색 정하기 */
        calendarView.appearance.headerTitleColor = UIColor.systemTeal
        calendarView.appearance.weekdayTextColor = UIColor.systemTeal
        calendarView.appearance.selectionColor = UIColor.systemBlue
        calendarView.appearance.todayColor = UIColor.systemTeal
        calendarView.calendarWeekdayView.weekdayLabels.last!.textColor = UIColor.magenta
        
        /* Weekday language change */
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "Mon"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "Tue"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "Wed"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "Thu"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "Fri"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "Sat"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "Sun"

        
        /* visible month */
        calendarView.placeholderType = .none
        
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
    
    /* 일요일 magenta 색상 변경 */
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        if Calendar.current.shortWeekdaySymbols[day] == "일" {
            return UIColor.magenta
        } else {
            return .systemTeal
        }
    }

}
