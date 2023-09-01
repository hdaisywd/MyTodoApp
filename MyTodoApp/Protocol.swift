
import Foundation

protocol MyCalendarViewDelegate: AnyObject {
    func didSelectDate(year: Int, month: Int, day: Int)
}
