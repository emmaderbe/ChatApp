import UIKit


class RegisterViewController: UIViewController {

    private let registerView = RegisterView()
    
    override func loadView() {
        self.view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegates()
    }
}

private extension RegisterViewController {
    func setupView() {
        observeKeyboard(for: registerView.scroll)
    }
    
    func setupDelegates() {
        registerView.delegate = self
        registerView.setupTextFieldDelegates(with: self)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case registerView.firstNameTextField:
            registerView.focusLastNameField()
        case registerView.lastNameTextField:
            registerView.focusEmailField()
        case registerView.emailTextField:
            registerView.focusPasswordField()
        case registerView.passwordTextField:
            registerView.triggerLoginIfNeeded()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}



extension RegisterViewController: RegisterViewDelegate {
    func loginButtonError(_ view: RegisterView) {
        alertUserLoginError()
    }
    
    func loginButtonAccess(_ view: RegisterView) {
        print("register tapped!")
    }
}

private extension RegisterViewController {
    func alertUserLoginError() {
        let alert = UIAlertController(
            title: "Woops",
            message: "Please enter all information to log in",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}
