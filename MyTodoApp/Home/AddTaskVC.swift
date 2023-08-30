
import Foundation
import UIKit
import FirebaseDatabase

class AddTaskVC: UIViewController {
    
    /* Add Task Title */
    let AddTaskTitle = UILabel()
    
    /* Task TextField */
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let titleTextField = UITextField()
    let contentTextField = UITextField()
    let taskSaveButton = UIButton()
    
    /* Date Picker */
    let datePicker = UIDatePicker()
    let datePickerImage = UIImageView()
    
    /* Save Button */
    let saveButton = UIButton(type: .roundedRect)
    
    /* Save Manager */
    let taskManager = TaskManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black 
        
        setAddTaskTitle()
        setTaskField()
        setDatePicker()
        setSaveButton()
    }
    
    /* Add Task Title */
    func setAddTaskTitle() {
        AddTaskTitle.text = "Add Task"
        AddTaskTitle.font = UIFont.boldSystemFont(ofSize: 30)
        AddTaskTitle.textColor = .white
        
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
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: AddTaskTitle.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: AddTaskTitle.bottomAnchor, constant: 20)
        ])
        
        titleTextField.placeholder = "Please enter a title."
        titleTextField.textColor = .gray
        
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
        
        contentLabel.text = "Content"
        contentLabel.font = .systemFont(ofSize: 20)
        contentLabel.textColor = .white
        
        view.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            contentLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10)
        ])
        
        contentTextField.placeholder = "Please enter a content."
        view.addSubview(contentTextField)
        contentTextField.textColor = .gray
        
        contentTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentTextField.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
            contentTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            contentTextField.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10)
        ])
        
        
    }
    
    /* Date Picker */
    func setDatePicker() {
        datePickerImage.image = UIImage(systemName: "clock")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
        datePickerImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePickerImage)
        NSLayoutConstraint.activate([
            datePickerImage.leadingAnchor.constraint(equalTo: contentTextField.leadingAnchor),
            datePickerImage.topAnchor.constraint(equalTo: contentTextField.bottomAnchor, constant: 20)
        ])
        
        /* datePicker 디자인 */
        datePicker.backgroundColor = .systemTeal
        datePicker.layer.cornerRadius = 10
        datePicker.layer.masksToBounds = true
        
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        
        view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: datePickerImage.trailingAnchor, constant: 10),
            datePicker.centerYAnchor.constraint(equalTo: datePickerImage.centerYAnchor)
        ])
    }
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    /* Save Button */
    func setSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.setBackgroundImage(UIImage(systemName: "rectangle.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), for: .normal)
        
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
        guard let saveTitle = titleTextField.text else {
            print("task에 입력한 값이 없습니다.")
            return
        }
        
        guard let saveContent = contentTextField.text else {
            print("content에 입력한 값이 없습니다.")
            return
        }
        
        // 날짜 좀 더 효과적으로 저장할 방법은 없을까..?
        let saveDate = datePicker.date.formatted().split(separator: " ")[0].split(separator: "/").map{Int($0)!}
        
        let newTask = Task(
            taskId: UUID().uuidString,
            title: saveTitle,
            content: saveContent,
            checkbox: false,
            starred: false,
            dueDateYear: saveDate[2],
            dueDateMonth: saveDate[0],
            dueDateDay: saveDate[1]
        )

        taskManager.createTask(task: newTask)

        taskManager.readTask(taskID: newTask.taskId) { task in
            if let task = task {
                print("Task Saved:", task)
            } else {
                print("Task not found.")
            }
        }
        
        dismiss(animated: true)
    }
}
