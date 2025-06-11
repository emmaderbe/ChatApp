import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsViewController: UIViewController {
    private let conversationsView = ConversationsView()
    private let viewModel: ConversationsViewModelProtocol
    
    init(viewModel: ConversationsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = conversationsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.validateAuth()
    }
}

private extension ConversationsViewController {
    func setupDelegates() {
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.onError = { [weak self] in
            let vc = LoginViewController(viewModel: LoginViewModel())
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: false)
        }
        
        viewModel.onSuccess = {
            print("Success")
        }
    }
}
