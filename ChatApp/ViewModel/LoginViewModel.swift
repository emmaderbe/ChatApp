import Foundation
import FirebaseAuth

protocol LoginViewModelProtocol: AnyObject {
    var onSuccess: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    
    func auth(email: String, password: String)
    func loginSuccess()
    func showRegister()
}

final class LoginViewModel: BaseViewModel, LoginViewModelProtocol {
    
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func loginSuccess() {
        router.start()
    }
    
    func showRegister() {
        router.showRegister()
    }
}

extension LoginViewModel {
    func auth(email: String, password: String) {
        Auth.auth().signIn(
            withEmail: email,
            password: password)
        { [weak self] result, error in
            if let error = error {
                self?.onError?(error)
            } else {
                self?.onSuccess?()
            }
        }
    }
}
