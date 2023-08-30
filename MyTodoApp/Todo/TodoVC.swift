
import Foundation
import UIKit

class TodoVC: TodoTableVC {
    /* get date */
    var year = 0
    var month = 0
    var day = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Today Todo"
        navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        vcLabelStr = "🐯 Do It Today!"
        
        setVcLabel()
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
    override func loadDateData(completion: @escaping () -> Void) {
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
}
