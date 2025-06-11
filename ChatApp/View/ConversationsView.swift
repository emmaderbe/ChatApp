import UIKit

final class ConversationsView: UIView {
    
    private let emptyConversationsLabel = LabelFactory.titleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConversationsView {
    func setupView() {
        [emptyConversationsLabel].forEach { addSubview($0) }
    }
    
    func setupText() {
        emptyConversationsLabel.text = "No Conversations :("
    }
}
