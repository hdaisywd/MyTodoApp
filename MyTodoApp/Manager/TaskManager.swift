
import UIKit
import Firebase
import FirebaseDatabase

class TaskManager {
    
    var ref: DatabaseReference!
       
      init() {
          ref = Database.database(url: "https://mytodoapp-85e4e-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
      }
      
      func createTask(task: Task) {
          let taskData: [String: Any] = [
              "taskId": task.taskId,
              "title": task.title,
              "content": task.content,
              "checkbox": task.checkbox,
              "starred": task.starred,
              "dueDateYear": task.dueDateYear,
              "dueDateMonth": task.dueDateMonth,
              "dueDateDay": task.dueDateDay
          ]
          
          ref.child("tasks").child(task.taskId).setValue(taskData) { error, _ in
              if let error = error {
                  print("Error creating task: \(error)")
              } else {
                  print("Task created successfully!")
              }
          }
      }
      
      func readTask(taskID: String, completion: @escaping (Task?) -> Void) {
          ref.child("tasks").child(taskID).observeSingleEvent(of: .value) { snapshot in
              if let taskDict = snapshot.value as? [String: Any],
                 let taskId = taskDict["taskId"] as? String,
                 let title = taskDict["title"] as? String,
                 let content = taskDict["content"] as? String,
                 let checkbox = taskDict["checkbox"] as? Bool,
                 let starred = taskDict["starred"] as? Bool,
                 let dueDateYear = taskDict["dueDateYear"] as? Int,
                 let dueDateMonth = taskDict["dueDateMonth"] as? Int,
                 let dueDateDay = taskDict["dueDateDay"] as? Int {
                  let task = Task(taskId: taskId,
                                  title: title,
                                  content: content,
                                  checkbox: checkbox,
                                  starred: starred,
                                  dueDateYear: dueDateYear,
                                  dueDateMonth: dueDateMonth,
                                  dueDateDay: dueDateDay)
                  completion(task)
              } else {
                  completion(nil)
              }
          }
      }
      
      func updateTask(taskID: String, updatedTask: Task) {
          let taskData: [String: Any] = [
              "taskId": updatedTask.taskId,
              "title": updatedTask.title,
              "content": updatedTask.content,
              "checkbox": updatedTask.checkbox,
              "starred": updatedTask.starred,
              "dueDateYear": updatedTask.dueDateYear,
              "dueDateMonth": updatedTask.dueDateMonth,
              "dueDateDay": updatedTask.dueDateDay
          ]
          ref.child("tasks").child(taskID).setValue(taskData)
      }
      
      func deleteTask(taskID: String) {
          ref.child("tasks").child(taskID).removeValue()
      }
}


