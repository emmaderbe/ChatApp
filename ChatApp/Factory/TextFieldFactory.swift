import UIKit

final class TextFieldFactory {
    static func createTextField(with placeholder: String, and isSecure: Bool, and returnKey: UIReturnKeyType) -> UITextField {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = returnKey
        field.isSecureTextEntry = isSecure
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = placeholder
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }
}
