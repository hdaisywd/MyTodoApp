
import Foundation
import UIKit

class StarredListVC: TodoTableVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Starred"
        navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        vcLabelStr = "🐯 It's all about priorities!"
        
        setVcLabel()
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
    
    /* Data 불러오기 */
    override func loadDateData(completion: @escaping () -> Void) {
        let taskManager = TaskManager()
        
        taskManager.readAllTasks { [weak self] tasks in
            guard let self = self else { return } 
            
            for task in tasks {
                if task.starred == true {
                    self.starreditems.append(task)
                }
            }
            
            completion()
        }
    }

}
