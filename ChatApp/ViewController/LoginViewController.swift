import UIKit
import FirebaseAuth

// MARK: - Proporties and viewDidLoad()
final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        bindViewModel()
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
        let vc = RegisterViewController(viewModel: RegisterViewModel())
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
        auth()
    }
}

//MARK: - Auth with Farebase
private extension LoginViewController {
    func bindViewModel() {
        viewModel.onSuccess = { [weak self] in
            print("Успешный log in")
        }
        viewModel.onError = { [weak self] error in
            print("Ошибка: \(error.localizedDescription)")
        }
    }
    
    func auth() {
        let authData = loginView.authData()
        viewModel.auth(email: authData[0],
                       password: authData[1])
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
