
import Foundation
import UIKit

class TodoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dateLabel = UILabel()
    var myTableView = UITableView()
    
    /* get date */
    var year = 0
    var month = 0
    var day = 0
    
    /* table view task */
    var todoItems = [Task]()
    var starreditems = [Task]()
    var doneItems = [Task]()
    
    let blankPageLabel = UILabel()
    
    /* sections */
    let sections = ["Starred", "To do", "Done"]
    
    let monthInEnglish = [ "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Today Todo"
        navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
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
        
        todoItems = [Task]()
        starreditems = [Task]()
        doneItems = [Task]()
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
                    if task.starred == true { self.starreditems.append(task) }
                    else if task.checkbox == true { self.doneItems.append(task) }
                    else { self.todoItems.append(task) }
                }
            }
            
            completion()
        }
    }
    
    /* 날짜 안내를 위한 라벨 */
    func setDateLabel() {
        dateLabel.text = "🐯 Do It Today!"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 30)
        dateLabel.textColor = .white
        
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
        /* 똥글똥글 설정 */
        myTableView = UITableView(frame: view.bounds, style: .insetGrouped)
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        self.myTableView.backgroundColor = .black

        self.myTableView.register(CustomDetailViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(self.myTableView)
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            myTableView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            myTableView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            myTableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        ])
    }
    
    /* tableView */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cell 설정 시작")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CustomDetailViewCell
        
        if (indexPath.section == 0 ) {
            cell.titleStr = starreditems[indexPath.row].title
            cell.contentStr = starreditems[indexPath.row].content
        } else if (indexPath.section == 1) {
            cell.titleStr = todoItems[indexPath.row].title
            cell.contentStr = todoItems[indexPath.row].content
        } else {
            cell.titleStr = doneItems[indexPath.row].title
            cell.contentStr = doneItems[indexPath.row].title
        }
        
        return cell
    }
    
    /* Sections 구현 */
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count 
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if starreditems.count + todoItems.count + doneItems.count == 0 {
            loadBlankPage()
            myTableView.isHidden = true
            blankPageLabel.isHidden = false
            return 0
        }
        
        myTableView.isHidden = false
        blankPageLabel.isHidden = true
        
        if (section == 0) { return starreditems.count }
        if (section == 1) { return todoItems.count }
        return doneItems.count
    }
    
    /* Table View 내용 없을때 화면 구현 */
    func loadBlankPage() {
        blankPageLabel.text = "Nothing to do today!"
        blankPageLabel.font = .systemFont(ofSize: 20)
        blankPageLabel.textColor = .gray
        
        view.addSubview(blankPageLabel)
        blankPageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blankPageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blankPageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    /* Swipe Actions */
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var item: Task

        if indexPath.section == 0 { item =  starreditems[indexPath.row] }
        else if indexPath.section == 1 { item = todoItems[indexPath.row] }
        else { item = doneItems[indexPath.row] }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, success in
            taskManager.deleteTask(taskID: item.taskId)
            self.reloadTableView()
            success(true)
        }
        deleteAction.image = UIImage(systemName: "xmark")

        let starredAction = UIContextualAction(style: .normal, title: "Favorite") { action, view, success in
            let updatedTask = Task(taskId: item.taskId,
                                   title: item.title,
                                   content: item.content,
                                   checkbox: item.checkbox,
                                   starred: !item.starred,
                                   dueDateYear: item.dueDateYear,
                                   dueDateMonth: item.dueDateMonth,
                                   dueDateDay: item.dueDateDay)

            taskManager.updateTask(taskID: item.taskId, updatedTask: updatedTask)
            self.reloadTableView()
            success(true)
        }
        starredAction.image = UIImage(systemName: "star")

        return UISwipeActionsConfiguration(actions: [deleteAction, starredAction])
    }
    
    /* Swipe 후 reload 되게 수정 */
    func reloadTableView() {
        todoItems = [Task]()
        starreditems = [Task]()
        doneItems = [Task]()
        
        loadDateData{
            self.myTableView.reloadData()
        }
    }

}
