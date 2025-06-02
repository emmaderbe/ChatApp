import UIKit

// MARK: - Proporties and viewDidLoad()
final class LoginViewController: UIViewController {

    private let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegates()
    }
}

// MARK: - setupView and Delegates
private extension LoginViewController {
    func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
    }
    
    func setupDelegates() {
        loginView.delegate = self
        loginView.setupTextFieldDelegates(with: self)
    }
}

// MARK: - func didTapRegister()
private extension LoginViewController {
    @objc func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginView.focusNextField(after: textField)
        return true
    }
}

// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func loginButtonError() {
        alertUserLoginError()
    }
    
    func loginButtonAccess() {
        print("Login tapped!")
    }
}

// MARK: - add alertUserLoginError
private extension LoginViewController {
    func alertUserLoginError() {
        let alert = UIAlertController(
            title: "Woops",
            message: "Please enter all information to log in",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}
