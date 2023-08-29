
import Foundation
import UIKit

extension DateDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    /* 날짜에 맞는 task 불러오기 */
    /* 다시 살펴보고 TIL 작성하기 */
    func loadDateData(completion: @escaping () -> Void) {
        let taskManager = TaskManager()

        taskManager.readAllTasks { [weak self] tasks in
            guard let self = self else { return }  // 약한 참조 해제 시 nil이 될 수 있으므로, guard 문으로 self 옵셔널 바인딩

            for task in tasks {
                if task.dueDateYear == self.year && task.dueDateMonth == self.month && task.dueDateDay == self.day {
                    self.items.append(task)
                    print(task)
                    print("아직 for문 안입니다")
                }
            }

            // 모든 작업이 완료된 후 completion() 호출
            print("for문 탈출!")
            print(self.items)
            completion()
        }
    }

    
    /* 날짜 안내를 위한 라벨 */
    /* 옵셔널 벗기는 방법 */
    func setDateLabel() {
        dateLabel.text = "🐯 \(String(describing: monthInEnglish[month!-1] )) \(String(describing: day!))"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
    
    /* table view 초기 설정 */
    func setTableView() {
        self.myTableView.dataSource = self
        self.myTableView.delegate = self

        self.myTableView.register(CustomDetailViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(self.myTableView)
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            myTableView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            myTableView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            myTableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        ])

    }
    
    /* tableView  */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.items)
        print("items count: ", self.items.count)
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("tableView 실행")

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CustomDetailViewCell
        
        cell.titleLabel.text = items[indexPath.row].title
        cell.contentLabel.text = items[indexPath.row].content

        return cell
    }

}
