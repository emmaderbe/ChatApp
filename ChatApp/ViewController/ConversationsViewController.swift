import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsViewController: UIViewController {
    private let conversationsView = ConversationsView()
    private let dataSource = ConversationTableViewDataSource()
    private let delegate = ConversationsTableViewDelegate()
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
        setupView()
        viewModel.validateAuth()
    }
}

private extension ConversationsViewController {
    func setupView() {
        bindViewModel()
        setupDataSource()
        setupDelegate()
    }
    
    func bindViewModel() {
        viewModel.onError = { [weak self] in
            self?.viewModel.showLogin()
        }
        
        viewModel.onSuccess = { [ weak self] in
            self?.viewModel.loadChats()
        }
        
        viewModel.onChatsUpdate = { [weak self] chats in
            guard let self else { return }
            dataSource.updateChats(chats)
            delegate.updateChats(chats)
            conversationsView.reloadData()
        }
    }
}

private extension ConversationsViewController {
    func setupDataSource() {
        dataSource.delegate = self
        conversationsView.setDataSource(dataSource)
    }
    
    func setupDelegate() {
        delegate.delegate = self
        conversationsView.setDelegate(delegate)
    }
}

extension ConversationsViewController: ConversationTableViewDataSourceProtocol {
}

extension ConversationsViewController: ConversationTableViewDelegateProtocol {
    func didSelectTask(at index: Int) {
        print("want to select")
    }
}
