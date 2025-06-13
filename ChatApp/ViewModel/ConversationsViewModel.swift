import Foundation
import FirebaseAuth

protocol ConversationsViewModelProtocol: AnyObject {
    var onSuccess: (() -> Void)? { get set }
    var onError: (() -> Void)? { get set }
    var onChatsUpdate: (([Int]) -> Void)? { get set }
    
    func validateAuth()
    func loadChats()
    func showProfile()
    func showLogin()
}


final class ConversationsViewModel: BaseViewModel, ConversationsViewModelProtocol {
    var onSuccess: (() -> Void)?
    var onError: (() -> Void)?
    
    var onChatsUpdate: (([Int]) -> Void)?
    
    func showLogin() {
        router.showLogin()
    }
    func showProfile() {
        router.showProfile()
    }
}

extension ConversationsViewModel {
    func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            onError?()
        } else {
            onSuccess?()
        }
    }
    
    func loadChats() {
        let mockChats = [1, 2, 3, 4, 5, 6, 7, 8]
        onChatsUpdate?(mockChats)
    }
}
