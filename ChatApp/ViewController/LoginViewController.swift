import UIKit

class LoginViewController: UIViewController {

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

private extension LoginViewController {
    func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        observeKeyboard(for: loginView.scroll)
    }
    
    func setupDelegates() {
        loginView.delegate = self
        loginView.setupTextFieldDelegates(with: self)
    }
}

private extension LoginViewController {
    @objc func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.emailTextField {
            loginView.focusPasswordField()
        } else if textField == loginView.passwordTextField {
            loginView.triggerLoginIfNeeded()
        }
        return true
    }
}


extension LoginViewController: LoginViewDelegate {
    func loginButtonError(_ view: LoginView) {
        alertUserLoginError()
    }
    
    func loginButtonAccess(_ view: LoginView) {
        print("Login tapped!")
    }
}

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
