import UIKit

protocol RegisterViewDelegate: AnyObject {
    func registerButtonAccess()
    func registerButtonError()
    func imageTapped()
}

// MARK: - Proporties, init() and layoutSubviews()
final class RegisterView: UIView {
    weak var delegate: RegisterViewDelegate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.tintColor = .systemGray5
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let firstNameField: AuthTextField = {
        let field = AuthTextField()
        field.placeholder = "First Name..."
        field.returnKeyType = .continue
        field.isSecureTextEntry = false
        return field
    }()
    private let lastNameField: AuthTextField = {
        let field = AuthTextField()
        field.placeholder = "Last Name..."
        field.returnKeyType = .continue
        field.isSecureTextEntry = false
        return field
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
    
    private let registerBttn: UIButton = {
        let bttn = UIButton()
        bttn.setTitle("Register", for: .normal)
        bttn.backgroundColor = .systemGreen
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
            height: registerBttn.frame.maxY + 20
        )
    }
}

// MARK: - setupView, addGesture  and Contraints
private extension RegisterView {
    func setupView() {
        backgroundColor = .white
        
        addSubview(scrollView)
        [imageView, firstNameField, lastNameField, emailField, passwordField, registerBttn].forEach {
            scrollView.addSubview($0)
        }
        
        registerBttn
            .addTarget(
                self,
                action: #selector(didTapRegister),
                for: .touchUpInside
            )
        addGestureToImage()
        observeKeyboard(for: scrollView)
    }
    
    func addGestureToImage() {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapChangeProfilePic))
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
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
        
        firstNameField.frame = CGRect(
            x: 30,
            y: imageView.frame.maxY + 40,
            width: scrollView.width - 60,
            height: 52
        )
        lastNameField.frame = CGRect(
            x: 30,
            y: firstNameField.frame.maxY + 16,
            width: scrollView.width - 60,
            height: 52
        )
        emailField.frame = CGRect(
            x: 30,
            y: lastNameField.frame.maxY + 16,
            width: scrollView.width - 60,
            height: 52
        )
        
        passwordField.frame = CGRect(
            x: 30,
            y: emailField.frame.maxY + 16,
            width: scrollView.width - 60,
            height: 52)
        
        registerBttn.frame = CGRect(
            x: 30,
            y: passwordField.frame.maxY + 24,
            width: scrollView.width - 60,
            height: 52)
    }
}

// MARK: - didTapLogin() and didTapChangeProfilePic()
private extension RegisterView {
    @objc func didTapRegister() {
        if let firstName = firstNameField.text,
           let lastName = lastNameField.text,
           let email = emailField.text,
           let password = passwordField.text,
           !firstName.isEmpty,
           !lastName.isEmpty,
           !email.isEmpty,
           password.count >= 6
        {
            delegate?.registerButtonAccess()
        }
        else {
            delegate?.registerButtonError()
        }
    }
    
    @objc func didTapChangeProfilePic() {
        delegate?.imageTapped()
    }
}

// MARK: - add functionality to textField
extension RegisterView {
    private func getTextFieldsInOrder() -> [UITextField] {
        [firstNameField, lastNameField, emailField, passwordField]
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
            triggerLoginIfNeeded()
        }
    }
    
    private func triggerLoginIfNeeded() {
        didTapRegister()
    }
}

// MARK: - setupImage
extension RegisterView {
    func setupImage(with image: UIImage) {
        imageView.image = image
    }
}

