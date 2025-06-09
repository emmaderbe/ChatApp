import Foundation
import FirebaseAuth

protocol RegisterViewModelProtocol: AnyObject {
    var onSuccessAuth: (() -> Void)? { get set }
    var onErrorAuth: ((Error) -> Void)? { get set }
    var onErrorUserExist: (() -> Void)? { get set}
    
    func register(email: String, password: String, name: String, surname: String)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    var onSuccessAuth: (() -> Void)?
    var onErrorAuth: ((Error) -> Void)?
    var onErrorUserExist: (() -> Void)?
}

extension RegisterViewModel {
    func register(email: String, password: String, name: String, surname: String) {
        
        DataBaseManager.shared.userExist(with: email,
         complition: { [weak self] exist in
            guard !exist else {
                self?.onErrorUserExist?()
                return
            }
          
            Auth.auth().createUser(
                withEmail: email,
                password: password)
            { [weak self] result, error in
                if let error = error {
                    self?.onErrorAuth?(error)
                } else {
                    self?.onSuccessAuth?()
                    let profile = ChatAppUser(firstName: name,
                                              lastName: surname,
                                              emailAddress: email)
                    DataBaseManager.shared.insertUser(with: profile)
                }
            }
            
        })
    }
}
