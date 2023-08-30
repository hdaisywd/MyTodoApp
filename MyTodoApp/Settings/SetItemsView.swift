
import Foundation
import UIKit

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func setItemsTableView() {
        itemsView.register(CustomSettingsCell.self, forCellReuseIdentifier: CustomSettingsCell.cellId)
        itemsView.dataSource = self
        itemsView.delegate = self
        
        itemsView.isScrollEnabled = false
        
        setLayerForItemsView()

        view.addSubview(itemsView)
        itemsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemsView.leadingAnchor.constraint(equalTo: userProfileView.leadingAnchor),
            itemsView.trailingAnchor.constraint(equalTo: userProfileView.trailingAnchor),
            itemsView.topAnchor.constraint(equalTo: userProfileView.bottomAnchor, constant: 10),
            itemsView.heightAnchor.constraint(equalToConstant: CGFloat(cellHeight * items.count))
        ])
    }
    
    /* itemView 테두리 설정 */
    func setLayerForItemsView() {
        itemsView.layer.borderWidth = 0.5
        itemsView.layer.borderColor = UIColor.systemTeal.cgColor
        itemsView.layer.cornerRadius = 10
    }
    
    /* Delegate, Data Source 상속 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! CustomSettingsCell
        cell.name.text = items[indexPath.row]
        
        /* cell 자잘한 설정 */
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        
        return cell
    }
    
    /* tableView Cell 높이 설정 */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
}
