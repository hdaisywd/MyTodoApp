//
//  todoVC.swift
//  MyTodoApp
//
//  Created by Daisy Hong on 2023/08/24.
//

import Foundation
import UIKit

class StarredListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let label = UILabel()
    let myTableView = UITableView()
    
    /* get date */
    var year = 0
    var month = 0
    var day = 0
    
    /* table view task */
    var items = [Task]()
    
    let monthInEnglish = [ "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Starred List"
        
        setLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadStarredData{ self.setTableView() }
    }

    func loadStarredData(completion: @escaping () -> Void) {
        let taskManager = TaskManager()

        taskManager.readAllTasks { [weak self] tasks in
            guard let self = self else { return }  // 약한 참조 해제 시 nil이 될 수 있으므로, guard 문으로 self 옵셔널 바인딩

            for task in tasks {
                if task.starred == true {
                    self.items.append(task)
                }
            }

            completion()
        }
    }
    
    /* 날짜 안내를 위한 라벨 */
    func setLabel() {
        label.text = "🐯 It's all about priorities!"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
    
    /* table view 초기 설정 */
    func setTableView() {
        self.myTableView.dataSource = self
        self.myTableView.delegate = self

        self.myTableView.register(CustomDetailViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(self.myTableView)
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            myTableView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            myTableView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            myTableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        ])
    }
    
    /* tableView  */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cell 설정 시작")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CustomDetailViewCell

        cell.titleStr = items[indexPath.row].title
        cell.contentStr = items[indexPath.row].content

        print(items[indexPath.row].title, items[indexPath.row].content)

        return cell
    }
}
