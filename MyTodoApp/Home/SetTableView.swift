
import Foundation
import UIKit

extension DateDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    /* 날짜 안내를 위한 라벨 */
    /* 옵셔널 벗기는 방법 */
    func setDateLabel() {
        dateLabel.text = "🐯 \(String(describing: monthInEnglish[month!] )) \(String(describing: day!))"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
    
    /* table view 초기 설정 */
    func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(self.tableView)
        
        view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            tableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        ])
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }

}
