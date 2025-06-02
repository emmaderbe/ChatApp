import UIKit

final class AuthTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.placeholder = placeholder
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        self.leftViewMode = .always
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
