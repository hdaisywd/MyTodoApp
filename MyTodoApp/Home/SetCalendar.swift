//
//  SetCalendar.swift
//  MyTodoApp
//
//  Created by Daisy Hong on 2023/08/23.
//

import Foundation
import UIKit

extension HomeVC: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {

    /* 오늘의 날짜를 불러온다 */
    func getDate() -> [Int?] {
        let today = Date().formatted().components(separatedBy: " ")[0].components(separatedBy: "/")
        let year = Int(today[0]) ?? 1998
        let month = Int(today[1]) ?? 5
        let date = Int(today[2]) ?? 8

        return [year, month, date]
    }

    /* 캘린더를 불러온다 */
    func getCalendar(year: Int?, month: Int?, date: Int?) {
        calendarView.delegate = self
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "kr_KR")
        calendarView.fontDesign = .rounded

        /* 시작 일 정하기 */
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: date)

        /* view에 추가하기 */
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 500),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }

    /* 달력에서 날짜 선택 처리 */
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print("date selection 실행")
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents

        /* Date Detail 페이지 불러오기 */
        let dateDetailVC = DateDetailVC()
        self.present(dateDetailVC, animated: true)

        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }

    /* 선택된 날짜들에 라벨 붙이기 */
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        print("calendar decoration 실행")
        if let selectedDate = selectedDate, selectedDate == dateComponents {
            return .customView {
                let label = UILabel()
                label.text = "🐯"
                label.textAlignment = .center
                return label
            }
        }
        return nil
    }

    /* 날짜 선택 후 reload */
    func reloadDateView(date: Date?) {
        print("reload view 실행")
        if date == nil { return }
        let calendar = Calendar.current
        calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}
