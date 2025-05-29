import UIKit

// MARK: - Proporties and viewDidLoad()
final class RegisterViewController: UIViewController {
    
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

// MARK: - setupView and Delegates
private extension RegisterViewController {
    func setupView() {
        observeKeyboard(for: registerView.scroll)
    }
    
    func setupDelegates() {
        registerView.delegate = self
        registerView.setupTextFieldDelegates(with: self)
    }
}

// MARK: - UITextFieldDelegate
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

// MARK: - RegisterViewDelegate
extension RegisterViewController: RegisterViewDelegate {
    func imageTapped(_ view: RegisterView) {
        presentPhotoActionSheet()
    }
    
    func registerButtonError(_ view: RegisterView) {
        alertUserLoginError()
    }
    
    func registerButtonAccess(_ view: RegisterView) {
        print("register tapped!")
    }
}

// MARK: - add alertUserLoginError
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
