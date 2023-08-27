
import Foundation
import UIKit

extension DateDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    /* 날짜 안내를 위한 라벨 */
    /* 옵셔널 벗기는 방법 */
    func setDateLabel() {
        dateLabel.text = "🐯 \(String(describing: monthInEnglish[month!-1] )) \(String(describing: day!))"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
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
            myTableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            myTableView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            myTableView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            myTableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        ])

    }
    
    /* tableView  */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! CustomDetailViewCell
        cell.task.text = items[indexPath.row]

        return cell
    }

}
