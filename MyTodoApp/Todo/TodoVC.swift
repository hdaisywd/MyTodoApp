
import Foundation
import UIKit

class TodoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dateLabel = UILabel()
    let myTableView = UITableView()
    
    /* get date */
    var year = 0
    var month = 0
    var day = 0
    
    /* table view task */
    var items = [Task]()
    
    let monthInEnglish = [ "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = "Today Todo"
        
        setDateLabel()
        getDate()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDateData{
            self.myTableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        items = [Task]()
    }
    
    /* 날짜 가져오기 */
    func getDate() {
        let now = Date().formatted().split(separator: " ")[0].split(separator: "/")
        month = Int(now[0]) ?? 1998
        day = Int(now[1]) ?? 5
        year = Int(now[2]) ?? 8
    }
    
    /* Data 불러오기 */
    func loadDateData(completion: @escaping () -> Void) {
        let taskManager = TaskManager()

        taskManager.readAllTasks { [weak self] tasks in
            guard let self = self else { return } 

            for task in tasks {
                if task.dueDateYear == self.year && task.dueDateMonth == self.month && task.dueDateDay == self.day {
                    self.items.append(task)
                }
            }
            
            completion()
        }
    }
    
    /* 날짜 안내를 위한 라벨 */
    func setDateLabel() {
        dateLabel.text = "🐯 Do It Today!"
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
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cell 설정 시작")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CustomDetailViewCell

        cell.titleStr = items[indexPath.row].title
        cell.contentStr = items[indexPath.row].content

        print(items[indexPath.row].title, items[indexPath.row].content)

        return cell
    }
    
    /* Swipe Actions */
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration {
        
        let item = items[indexPath.row]
    
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, success in
            taskManager.deleteTask(taskID: item.taskId)
            success(true)
        }
        deleteAction.image = UIImage(systemName: "xmark")
        
        let starredAction = UIContextualAction(style: .normal, title: "Favorite") { [weak self] _, _, success in
            let updatedTask = Task(taskId: item.taskId,
                                   title: item.title,
                                   content: item.content,
                                   checkbox: item.checkbox,
                                   starred: true,
                                   dueDateYear: item.dueDateYear,
                                   dueDateMonth: item.dueDateMonth,
                                   dueDateDay: item.dueDateDay)
        
            taskManager.updateTask(taskID: item.taskId, updatedTask: updatedTask)
            success(true)
        }
        starredAction.image = UIImage(systemName: "star")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, starredAction])
    }

}
