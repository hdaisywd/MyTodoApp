
class EditTaskVC: TaskVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        super.AddTaskTitle.text = "Edit Todo"
        
        // loadData()
        setAddTaskTitle()
        setTaskField()
        setDatePicker()
        setSaveButton()
    }
    
    func loadData(_ task: Task, completion: @escaping () -> Void) {
        let taskManager = TaskManager()

        taskManager.readTask(taskID: task.taskId) { task in
            if let task = task {
                print("Read task:", task)
                super.initialTitleText = task.title
                super.initialContentText = task.content
            } else {
                print("Task not found.")
            }
            
            completion()
        }
    }
    
}
