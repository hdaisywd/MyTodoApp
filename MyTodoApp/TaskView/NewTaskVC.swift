
class NewTaskVC: TaskVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        super.taskTitleStr = "New Task"
        
        setTaskTitleLabel()
        setTaskField()
        setDatePicker()
        setSaveButton()
    }
   
}
