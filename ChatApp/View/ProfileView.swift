import UIKit
protocol ProfileViewProtocol: AnyObject {
    func bttnTapped()
}


final class ProfileView: UIView {
    weak var delegate: ProfileViewProtocol?
    
    private let logoutBttn: UIButton = {
        let bttn = UIButton()
        bttn.setTitle("Log out", for: .normal)
        bttn.backgroundColor = .systemRed
        bttn.setTitleColor(.white, for: .normal)
        bttn.layer.cornerRadius = 12
        bttn.layer.masksToBounds = true
        bttn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return bttn
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
        setupContraints()
    }
}

private extension ProfileView {
    func setupView() {
        backgroundColor = .clear
        
        [logoutBttn].forEach { addSubview($0) }
        
        logoutBttn.addTarget(self,
                             action: #selector(didTapLogoutBttn),
                             for: .touchUpInside)
    }
    
    func setupContraints() {
        let bottomInset = safeAreaInsets.bottom
        
        logoutBttn.frame = CGRect(x: 30,
                                  y: Int(frame.height - bottomInset - 120),
                                  width: Int(frame.width - 60),
                                  height: 52)
    }
}

private extension ProfileView {
    @objc func didTapLogoutBttn() {
        delegate?.bttnTapped()
    }
}
