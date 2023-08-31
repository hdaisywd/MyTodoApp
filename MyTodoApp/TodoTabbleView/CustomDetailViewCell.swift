
import Foundation
import UIKit

class CustomDetailViewCell: UITableViewCell {

    let titleLabel = UILabel()
    
    /* Checkmark Box */
    let checkboxButton = UIButton()
    
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
//        self.checkboxButton.addTarget(self, action: #selector(checkboxButtonAction), for: .touchUpInside)
        setCheckboxButton()
        setTitleLabel()
        cellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellLayout() {
        contentView.addSubview(checkboxButton)
        contentView.addSubview(titleLabel)

        /* contentview는 이렇게 해주면 안된다 */
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        checkboxButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: checkboxButton.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    /* Checkbox Button */
    func setCheckboxButton() {
        checkboxButton.setImage(UIImage(systemName: "circle")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    func setTitleLabel() {
        titleLabel.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: titleStr + "\n" + contentStr)
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: titleStr.count))
        attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: titleStr.count + 1, length: contentStr.count))
        
        titleLabel.attributedText = attributedText
    }

}
