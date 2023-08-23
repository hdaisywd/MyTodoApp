
import Foundation
import UIKit

class DateDetailVC: UIViewController {
    private let month: Int?
    private let day: Int?
    
    init(_ dateComponents: DateComponents?) {
        self.month = dateComponents?.month
        self.day = dateComponents?.day
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
    }

}
