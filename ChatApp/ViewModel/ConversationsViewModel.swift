import Foundation
import FirebaseAuth

protocol ConversationsViewModelProtocol: AnyObject {
    var onSuccess: (() -> Void)? { get set }
    var onError: (() -> Void)? { get set }
    func validateAuth()
}


final class ConversationsViewModel: ConversationsViewModelProtocol {
    var onSuccess: (() -> Void)?
    var onError: (() -> Void)?
}

extension ConversationsViewModel {
    func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            onError?()
        }
        onSuccess?()
    }
}
