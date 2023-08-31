
import Foundation
import UIKit

class TodoTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var myTableView = UITableView()
    
    /* vcLabel */
    let vcLabel = UILabel()
    var vcLabelStr = "No Label :("
    
    /* table view task */
    var todoItems = [Task]()
    var starreditems = [Task]()
    var doneItems = [Task]()
    
    /* Blank Page */
    let blankPageLabel = UILabel()
    var blankPageLabelStr = "No Label :("
    
    /* sections */
    var sections = ["Starred", "To do", "Done"]
    
    /* checkbox Action */
    private var cellInfo: Task?
    
    /* table view 초기 설정 */
    func setTableView() {
        /* 똥글똥글 설정 */
        myTableView = UITableView(frame: view.bounds, style: .insetGrouped)
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        self.myTableView.backgroundColor = .black

        self.myTableView.register(CustomDetailViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(self.myTableView)
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: vcLabel.bottomAnchor, constant: 20),
            myTableView.trailingAnchor.constraint(equalTo: vcLabel.trailingAnchor),
            myTableView.leadingAnchor.constraint(equalTo: vcLabel.leadingAnchor),
            myTableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        ])
    }
    
    /* 날짜 안내를 위한 라벨 */
    func setVcLabel() {
        vcLabel.text = vcLabelStr
        vcLabel.font = UIFont.boldSystemFont(ofSize: 30)
        vcLabel.textColor = .white
        
        view.addSubview(vcLabel)
        vcLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            vcLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vcLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            vcLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
    
    /* Data 불러오기 */
    func loadDateData(completion: @escaping () -> Void) {
        print("Something went wrong!")
        return 
    }
    
    /* tableView */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CustomDetailViewCell
        
        if (indexPath.section == 0 ) {
            cell.titleStr = starreditems[indexPath.row].title
            cell.contentStr = starreditems[indexPath.row].content
            cellInfo = starreditems[indexPath.row]
        } else if (indexPath.section == 1) {
            cell.titleStr = todoItems[indexPath.row].title
            cell.contentStr = todoItems[indexPath.row].content
            cellInfo = todoItems[indexPath.row]
        } else {
            cell.titleStr = doneItems[indexPath.row].title
            cell.contentStr = doneItems[indexPath.row].title
            cellInfo = doneItems[indexPath.row]
        }
        
        if cellInfo!.checkbox == true {
            cell.checkboxButton.setImage(UIImage(systemName: "checkmark.circle")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal), for: .normal)
            cell.backgroundColor = .systemGray
        } else {
            cell.checkboxButton.setImage(UIImage(systemName: "circle")?.withTintColor(UIColor.systemTeal, renderingMode: .alwaysOriginal), for: .normal)
            cell.backgroundColor = .systemMint
        }
        
        cell.checkboxButton.addTarget(self, action: #selector(checkmarkButtonTapped), for: .touchUpInside)
        
        /* 여기서 하면 되는데 커스텀셀 클래스에서 하면 안댐 */
        // cell.backgroundColor = .systemMint
        cell.selectionStyle = .none
        
        return cell
    }
    
    /* Sections 구현 */
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    /* Table View Section Title Color change */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel()
        
        headerView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        headerLabel.text = sections[section]
        headerLabel.textColor = .white

        return headerView
    }
    
    /* Header 사이즈 */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if starreditems.count + todoItems.count + doneItems.count == 0 {
            loadBlankPage()
            myTableView.isHidden = true
            blankPageLabel.isHidden = false
            return 0
        }
        
        myTableView.isHidden = false
        blankPageLabel.isHidden = true
        
        if (section == 0) { return starreditems.count }
        if (section == 1) { return todoItems.count }
        return doneItems.count
    }
    
    /* Table View 내용 없을때 화면 구현 */
    func loadBlankPage() {
        blankPageLabel.text = blankPageLabelStr
        blankPageLabel.font = .systemFont(ofSize: 20)
        blankPageLabel.textColor = .gray
        
        view.addSubview(blankPageLabel)
        blankPageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blankPageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blankPageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    /* Checkmark Button Behavior */
    @objc func checkmarkButtonTapped() {
        guard cellInfo != nil else {
            print("cellInfo loading 실패")
            return
        }
        
        let updatedTask = Task(taskId: cellInfo!.taskId,
                               title: cellInfo!.title,
                               content: cellInfo!.content,
                               checkbox: !cellInfo!.checkbox,
                               starred: cellInfo!.starred,
                               dueDateYear: cellInfo!.dueDateYear,
                               dueDateMonth: cellInfo!.dueDateMonth,
                               dueDateDay: cellInfo!.dueDateDay)

        taskManager.updateTask(taskID: cellInfo!.taskId, updatedTask: updatedTask)
        self.reloadTableView()
    }
    
    /* Swipe Actions */
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var item: Task

        if indexPath.section == 0 { item =  starreditems[indexPath.row] }
        else if indexPath.section == 1 { item = todoItems[indexPath.row] }
        else { item = doneItems[indexPath.row] }
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { action, view, success in
            taskManager.deleteTask(taskID: item.taskId)
            self.reloadTableView()
            success(true)
        }
        deleteAction.image = UIImage(systemName: "xmark")

        let starredAction = UIContextualAction(style: .normal, title: "Favorite") { action, view, success in
            let updatedTask = Task(taskId: item.taskId,
                                   title: item.title,
                                   content: item.content,
                                   checkbox: item.checkbox,
                                   starred: !item.starred,
                                   dueDateYear: item.dueDateYear,
                                   dueDateMonth: item.dueDateMonth,
                                   dueDateDay: item.dueDateDay)

            taskManager.updateTask(taskID: item.taskId, updatedTask: updatedTask)
            self.reloadTableView()
            success(true)
        }
        starredAction.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        starredAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [deleteAction, starredAction])
    }
    
    /* Swipe 후 reload 되게 수정 */
    func reloadTableView() {
        todoItems = [Task]()
        starreditems = [Task]()
        doneItems = [Task]()
        
        loadDateData{
            self.myTableView.reloadData()
        }
    }

}
