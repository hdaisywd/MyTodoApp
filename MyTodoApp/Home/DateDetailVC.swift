
import Foundation
import UIKit

class DateDetailVC: TodoTableVC {
    /* 선택된 날짜 */
    let year: Int?
    let month: Int?
    let day: Int?
    
    let monthInEnglish = [ "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec" ]
    
    /* 초기화 */
    init(_ dateComponents: DateComponents?) {
        self.year = dateComponents?.year
        self.month = dateComponents?.month
        self.day = dateComponents?.day
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray

        vcLabelStr = "🐯 \(String(describing: monthInEnglish[month!-1] )) \(String(describing: day!))"
        blankPageLabelStr = "No todo yet!"
        
        setVcLabel()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDateData{
            self.myTableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
