
class NewTaskVC: TaskVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setAddTaskTitle()
        setTaskField()
        setDatePicker()
        setSaveButton()
    }
   
}
