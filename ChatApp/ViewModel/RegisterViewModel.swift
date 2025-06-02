import Foundation
import FirebaseAuth

protocol RegisterViewModelProtocol: AnyObject {
    var onSuccess: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    
    func auth(email: String, password: String)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func auth(email: String, password: String) {
        Auth.auth().createUser(
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
