import Foundation
import FirebaseAuth

protocol ProfileViewModelProtocol: AnyObject {
    var onSuccess: (() -> Void)? { get set }
    var onError: (() -> Void)? { get set }
    
    func logout()
}


final class ProfileViewModel: ProfileViewModelProtocol {
    var onSuccess: (() -> Void)?
    var onError: (() -> Void)?
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
