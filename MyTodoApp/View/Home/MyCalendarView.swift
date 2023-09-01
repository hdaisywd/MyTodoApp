
import Foundation
import UIKit
import FSCalendar

class MyCalendarView: FSCalendar, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    weak var myDelegate: MyCalendarViewDelegate?
    
    /* 튜터님께 질문하러 가야겠다 ~  */
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /* Calendar Detail 설정 */
    func commonInit() {
        
        /* 채택 */
        self.delegate = self
        self.dataSource = self
        
        /* 월요일부터 시작 */
        self.firstWeekday = 2
        
        /* Header */
        self.appearance.headerDateFormat = "YYYY / MM"
        self.appearance.headerMinimumDissolvedAlpha = 0.0
        
        /* 캘린더 색 정하기 */
        self.appearance.headerTitleColor = UIColor.systemTeal
        self.appearance.weekdayTextColor = UIColor.systemTeal
        self.appearance.selectionColor = UIColor.systemBlue
        self.appearance.todayColor = UIColor.systemTeal
        self.calendarWeekdayView.weekdayLabels.last!.textColor = UIColor.magenta
        
        /* Weekday language change */
        self.calendarWeekdayView.weekdayLabels[0].text = "Mon"
        self.calendarWeekdayView.weekdayLabels[1].text = "Tue"
        self.calendarWeekdayView.weekdayLabels[2].text = "Wed"
        self.calendarWeekdayView.weekdayLabels[3].text = "Thu"
        self.calendarWeekdayView.weekdayLabels[4].text = "Fri"
        self.calendarWeekdayView.weekdayLabels[5].text = "Sat"
        self.calendarWeekdayView.weekdayLabels[6].text = "Sun"
        
        /* visible month */
        self.placeholderType = .none
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
    
    /* 클릭 한 버튼 action 넘겨주기 */
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
        
        myDelegate?.didSelectDate(year: year, month: month, day: day)
    }
    
    func didSelectDate(year: Int, month: Int, day: Int) {
        print("Selected Date: \(year)-\(month)-\(day)")
    }
    
}
