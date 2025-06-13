import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {
    private let profileView = ProfileView()
    private let viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
}

private extension ProfileViewController {
    func setupDelegates() {
        profileView.delegate = self
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.onSuccess = { [weak self] in
            self?.viewModel.showLogin()
        }

        viewModel.onError = { [weak self] in
            self?.alertLogoutError()
        }
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func bttnTapped() {
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.logout()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
}

private extension ProfileViewController {
    func alertLogoutError() {
        _ = AuthAlertFactory.present(title: "Woops",
                                        message: "Something went wrong. Try again",
                                        on: self)
    }
}
