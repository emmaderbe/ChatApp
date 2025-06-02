import UIKit

protocol LoginViewDelegate: AnyObject {
    func loginButtonAccess()
    func loginButtonError()
}

// MARK: - Proporties, init() and layoutSubviews()
final class LoginView: UIView {
    weak var delegate: LoginViewDelegate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let emailField: AuthTextField = {
        let field = AuthTextField()
        field.placeholder = "Email Address..."
        field.returnKeyType = .continue
        field.isSecureTextEntry = false
        return field
    }()
    
    private let passwordField: AuthTextField = {
        let field = AuthTextField()
        field.placeholder = "Password"
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        return field
    }()

    private let loginBttn: UIButton = {
        let bttn = UIButton()
        bttn.setTitle("Log In", for: .normal)
        bttn.backgroundColor = .link
        bttn.setTitleColor(.white, for: .normal)
        bttn.layer.cornerRadius = 12
        bttn.layer.masksToBounds = true
        bttn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return bttn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContraints()
        
        scrollView.contentSize = CGSize(
            width: scrollView.frame.width,
            height: loginBttn.frame.maxY + 20
        )
    }
}

// MARK: - setupView  and Contraints
private extension LoginView {
    func setupView() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginBttn)
        
        loginBttn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        observeKeyboard(for: scrollView)
    }
    
    func setupContraints() {
        scrollView.frame = bounds
        
        let imageSize = scrollView.width / 3
        imageView.frame = CGRect(
            x: (scrollView.width - imageSize) / 2,
            y: 60,
            width: imageSize,
            height: imageSize
        )
        imageView.layer.cornerRadius = imageView.width / 2
        
        emailField.frame = CGRect(
            x: 30,
            y: imageView.frame.maxY + 40,
            width: scrollView.width - 60,
            height: 52
        )
        
        passwordField.frame = CGRect(
            x: 30,
            y: emailField.frame.maxY + 16,
            width: scrollView.width - 60,
            height: 52)
        
        loginBttn.frame = CGRect(
            x: 30,
            y: passwordField.frame.maxY + 24,
            width: scrollView.width - 60,
            height: 52)
    }
}

// MARK: - didTapLogin()
private extension LoginView {
    @objc func didTapLogin() {
        if let email = emailField.text,
           let password = passwordField.text,
           !email.isEmpty,
           password.count >= 6
        {
            delegate?.loginButtonAccess()
        }
        else {
            delegate?.loginButtonError()
        }
    }
}

extension LoginView {
    func authData() -> [String] {
        return [emailField.text ?? "",
                passwordField.text ?? ""]
    }
}

// MARK: - add functionality to textField
extension LoginView {
    private func getTextFieldsInOrder() -> [UITextField] {
        [emailField, passwordField]
    }
    
    func setupTextFieldDelegates(with delegate: UITextFieldDelegate) {
        let textFields = getTextFieldsInOrder()
        textFields.forEach { $0.delegate = delegate
        }
    }
    
    func focusNextField(after textField: UITextField) {
        let textFields = getTextFieldsInOrder()
        
        guard let index = textFields.firstIndex(of: textField) else {
            textField.resignFirstResponder()
            return
        }
        
        if index + 1 < textFields.count {
            textFields[index + 1].becomeFirstResponder()
        } else {
            didTapLogin()
        }
    }
}

