import UIKit

final class TabBarController: UITabBarController {
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
}

extension TabBarController {
    func generateTabBar() {
        viewControllers = [
            generateVC(vc: ConversationsViewController(viewModel: ConversationsViewModel(router: router)),
                       image: UIImage(systemName: "message.fill"),
                       title: "Chats"),
            generateVC(vc: ProfileViewController(viewModel: ProfileViewModel(router: router)),
                       image: UIImage(systemName: "person.fill"),
                       title: "Profile")
        ]
    }
}

extension TabBarController {
    func generateVC(vc: UIViewController, image: UIImage?, title: String) -> UIViewController {
        vc.tabBarItem.image = image
        vc.tabBarItem.title = title
        vc.navigationItem.title = title
        vc.navigationItem.title
        
        let navVC = UINavigationController(rootViewController: vc)
        return navVC
    }
}

extension TabBarController {
    private func setTabBarAppearance() {
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.itemPositioning = .centered
        tabBar.barStyle = .default
    }
}
