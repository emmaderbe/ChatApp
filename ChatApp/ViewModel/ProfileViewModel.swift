import Foundation
import FirebaseAuth

protocol ProfileViewModelProtocol: AnyObject {
    var onSuccess: (() -> Void)? { get set }
    var onError: (() -> Void)? { get set }
    
    func logout()
    func showLogin()
}


final class ProfileViewModel: BaseViewModel, ProfileViewModelProtocol {
    var onSuccess: (() -> Void)?
    var onError: (() -> Void)?
    
    func showLogin() {
        router.popToRoot()
        router.showLogin()
    }
}

extension ProfileViewModel {
    func logout() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            onSuccess?()
        } catch {
            onError?()
    }
    }
}
