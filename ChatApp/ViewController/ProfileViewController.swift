import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {
    private let profileView = ProfileView()
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.delegate = self
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func bttnTapped() {

        let actionSheet = UIAlertController(title: "",
                                            message: "",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log out",
                                            style: .destructive,
                                            handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                let vc = LoginViewController(viewModel: LoginViewModel())
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
            } catch {
            print("Failed")
        }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet,animated: true)
}
}
