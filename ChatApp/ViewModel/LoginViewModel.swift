import Foundation
import FirebaseAuth

protocol LoginViewModelProtocol: AnyObject {
    var onSuccess: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    
    func auth(email: String, password: String)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
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
