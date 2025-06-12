import UIKit

final class ConversationViewCell: UITableViewCell {
    private let namesLabel = LabelFactory.ordinaryLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) не реализован")
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
}

private extension ConversationViewCell {
    func setupCell() {
        contentView.addSubview(namesLabel)
        namesLabel.text = "Hello world"
    }
    
    func setupConstraints() {
        let labelWidth: CGFloat = contentView.frame.width - 40
        let labelHeight: CGFloat = 24
        
        namesLabel.frame = CGRect(
            x: (contentView.frame.width - labelWidth) / 2,
            y: (contentView.frame.height - labelHeight) / 2,
            width: labelWidth,
            height: labelHeight
        )
    }
}

//extension ConversationViewCell {
//    func configure(with data: ConversationEntity) {
//        namesLabel.text = data.names
//    }
//}


extension ConversationViewCell {
    static var identifier: String {
        String(describing: ConversationViewCell.self)
    }
}

