
import UIKit
import Firebase
import FirebaseDatabase

class TaskManager {
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func createTask(task: Tasks) {
        let taskData: [String: Any] = [
            "taskId": task.taskId,
            "task": task.task ?? "",
            "checkbox": task.checkbox,
            "starred": task.starred,
            "dueDate": task.dueDate.timeIntervalSince1970
        ]
        
        ref.child("Tasks").child("\(task.taskId)").setValue(taskData) { error, _ in
            if let error = error {
                print("Error creating task: \(error)")
            } else {
                print("Task created successfully!")
            }
        }
    }
    
    func readTask(taskID: String, completion: @escaping ([String: Any]?) -> Void) {
        ref.child("tasks").child(taskID).observeSingleEvent(of: .value) { snapshot in
            if let task = snapshot.value as? [String: Any] {
                completion(task)
            } else {
                completion(nil)
            }
        }
    }
    
    func updateTask(taskID: String, updatedTask: [String: Any]) {
        ref.child("tasks").child(taskID).setValue(updatedTask)
    }
    
    func deleteTask(taskID: String) {
        ref.child("tasks").child(taskID).removeValue()
    }
}


