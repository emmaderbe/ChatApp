import UIKit
import FirebaseAuth
import JGProgressHUD

// MARK: - Proporties and viewDidLoad()
final class RegisterViewController: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
    private let registerView = RegisterView()
    private let viewModel: RegisterViewModelProtocol
    
    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
}

// MARK: - setupView and Delegates
private extension RegisterViewController {
    func setupDelegates() {
        bindViewModel()
        registerView.delegate = self
        registerView.setupTextFieldDelegates(with: self)
    }
}

// MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registerView.focusNextField(after: textField)
        return true
    }
}

// MARK: - RegisterViewDelegate
extension RegisterViewController: RegisterViewDelegate {
    func imageTapped() {
        presentPhotoActionSheet()
    }
    
    func registerButtonError() {
        alertUserInformationError()
    }
    
    func registerButtonAccess() {
        register()
    }
}

//MARK: - Auth with Farebase
private extension RegisterViewController {
    func bindViewModel() {
        viewModel.onSuccessAuth = { [weak self] in
            self?.hideLoading()
            self?.viewModel.registerSuccess()
            
        }
        
        viewModel.onErrorAuth = { [weak self] error in
            self?.hideLoading()
            print("Ошибка: \(error.localizedDescription)")
        }
        
        viewModel.onErrorUserExist = { [weak self] in
            self?.hideLoading()
            self?.alertRegistrationError()
        }
    }
    
    func register() {
        let authData = registerView.registerData()
        
        guard let email = authData["email"],
              let password = authData["password"],
              let firstName = authData["firstName"],
              let lastName = authData["lastName"]
        else {return}
        showLoading()
        viewModel.register(email: email,
                           password: password,
                           name: firstName,
                           surname: lastName)
    }
}

// MARK: - alerts
private extension RegisterViewController {
    func alertUserInformationError() {
        let _ = AuthAlertFactory.present(title: "Woops",
                                        message: "Please enter all information to register",
                                        on: self)
    }
    
    func alertRegistrationError() {
        let _ = AuthAlertFactory.present(title: "Woops",
                                             message: "Looks like a user account for that email address already exist",
                                             on: self)
    }

}

// MARK: - add actionSheet
private extension RegisterViewController {
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(
            title: "Profile Picture",
            message: "How would you like to select a picture?",
            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel))
        actionSheet.addAction(UIAlertAction(
            title: "Take Photo",
            style: .default, handler: { [weak self] _ in
                self?.presentCamera()
            }))
        actionSheet.addAction(UIAlertAction(
            title: "Choose Photo",
            style: .default, handler: { [weak self] _ in
                self?.presentPhotoPicker()
            }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        
        registerView.setupImage(with: selectedImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

private extension RegisterViewController {
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.spinner.show(in: strongSelf.view)
        }
    }

    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.dismiss()
        }
    }
}
