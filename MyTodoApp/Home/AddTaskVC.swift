
import Foundation
import UIKit
import FirebaseDatabase

class AddTaskVC: UIViewController {
    
    /* Add Task Title */
    let AddTaskTitle = UILabel()
    
    /* Task TextField */
    let taskImageView = UIImageView()
    let task = UITextField()
    let taskSaveButton = UIButton()
    
    /* Date Picker */
    let datePicker = UIDatePicker()
    let datePickerImage = UIImageView()
    
    /* Save Button */
    let saveButton = UIButton(type: .roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setAddTaskTitle()
        setTaskField()
        setDatePicker()
        setSaveButton()
    }
    
    /* Add Task Title */
    func setAddTaskTitle() {
        AddTaskTitle.text = "Add Task"
        AddTaskTitle.font = UIFont.boldSystemFont(ofSize: 30)
        
        view.addSubview(AddTaskTitle)
        AddTaskTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            AddTaskTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            AddTaskTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            AddTaskTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
    
    /* TaskField */
    func setTaskField() {
        taskImageView.image = UIImage(systemName: "square.and.pencil")
        view.addSubview(taskImageView)
        taskImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskImageView.leadingAnchor.constraint(equalTo: AddTaskTitle.leadingAnchor),
            taskImageView.topAnchor.constraint(equalTo: AddTaskTitle.bottomAnchor, constant: 10)
        ])
        
        task.placeholder = "Please enter a task."
        view.addSubview(task)
        task.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            task.leadingAnchor.constraint(equalTo: taskImageView.trailingAnchor, constant: 5),
            task.topAnchor.constraint(equalTo: taskImageView.topAnchor)
        ])
    }
    
    /* Date Picker */
    func setDatePicker() {
        datePickerImage.image = UIImage(systemName: "clock")
        datePickerImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePickerImage)
        NSLayoutConstraint.activate([
            datePickerImage.leadingAnchor.constraint(equalTo: taskImageView.leadingAnchor),
            datePickerImage.topAnchor.constraint(equalTo: taskImageView.bottomAnchor, constant: 10)
        ])
        
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        
        view.addSubview(datePicker)

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: datePickerImage.trailingAnchor, constant: 5),
            datePicker.centerYAnchor.constraint(equalTo: datePickerImage.centerYAnchor)
        ])
    }
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    func setSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setBackgroundImage(UIImage(systemName: "rectangle.fill"), for: .normal)
        
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            saveButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            saveButton.topAnchor.constraint(equalTo: datePickerImage.bottomAnchor, constant: 5),
            saveButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    /* str 에러 처리는 나중에 생각해보자... 일단 저장하는 방법부터! */
    @objc private func saveButtonAction() {
        guard let saveTask = task.text else {
            print("task에 입력한 값이 없습니다.")
            return
        }
    }
    

}
