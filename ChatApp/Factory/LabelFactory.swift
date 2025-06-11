import UIKit

final class LabelFactory {
    static func titleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24,
                                 weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }
    
    static func ordinaryLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14,
                                 weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }
}

