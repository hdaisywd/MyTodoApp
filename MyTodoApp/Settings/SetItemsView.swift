
import Foundation
import UIKit

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func setItemsTableView() {
        itemsView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellId)
        itemsView.dataSource = self
        itemsView.delegate = self

        view.addSubview(itemsView)
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemsView.leadingAnchor.constraint(equalTo: userProfileView.leadingAnchor),
            itemsView.trailingAnchor.constraint(equalTo: userProfileView.trailingAnchor),
            itemsView.topAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: 10),
            itemsView.heightAnchor.constraint(equalToConstant: CGFloat(cellHeight * items.count))
        ])
    }
    
    /* Delegate, Data Source 상속 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("items.count: ", items.count)
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell 설정 진입")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! CustomTableViewCell
        cell.name.text = items[indexPath.row]
        return cell
    }
    
    /* tableView Cell 높이 설정 */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("cell 높이 설정")
        return CGFloat(cellHeight)
    }
}
