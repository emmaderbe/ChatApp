import UIKit

final class ConversationsView: UIView {
    private let emptyConversationsLabel = LabelFactory.titleLabel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(ConversationViewCell.self, forCellReuseIdentifier: ConversationViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
}

private extension ConversationsView {
    func setupView() {
        backgroundColor = .white
        [tableView, emptyConversationsLabel].forEach { addSubview($0)}
        
        emptyConversationsLabel.isHidden = true
    }
    
    func setupConstraints() {
        let safeTop = safeAreaInsets.top
        let safeBottom = safeAreaInsets.bottom
        
        tableView.frame = CGRect(
            x: 0,
            y: safeTop,
            width: frame.width,
            height: frame.height - safeTop - safeBottom
        )
        
        emptyConversationsLabel.frame = CGRect(
            x: 20,
            y: (frame.height - 100) / 2,
            width: frame.width - 40,
            height: 100
        )
    }
}

extension ConversationsView {
    func setDataSource(_ dataSource: ConversationTableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func setDelegate(_ delegate: ConversationsTableViewDelegate) {
        tableView.delegate = delegate
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
