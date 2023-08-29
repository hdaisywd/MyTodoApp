
import Foundation
import UIKit

class CustomDetailViewCell: UITableViewCell {
    
    /* content도 화면에 표시할 방법 찾아보기 */
    let checkbox = UIButton()
    let titleLabel = UILabel()
    
    /* init은 셀이 초기화 될때만 호출됨. 재사용될때마다 내용이 바뀌어야한다. */
    var titleStr = "Title" {
        didSet {
            setTitleLabel()
        }
    }
    
    var contentStr = "Content" {
        didSet {
            setTitleLabel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("customcell init")
        setCheckBox()
        setTitleLabel()
        cellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellLayout() {
        self.addSubview(checkbox)
        self.addSubview(titleLabel)

        checkbox.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        checkbox.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: checkbox.topAnchor).isActive = true
    }
    
    func setCheckBox() {
        checkbox.setImage(UIImage(systemName: "circle")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    func setTitleLabel() {
        titleLabel.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: titleStr + "\n" + contentStr)
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: titleStr.count))
        attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: titleStr.count + 1, length: contentStr.count))
        
        titleLabel.attributedText = attributedText
    }
}
