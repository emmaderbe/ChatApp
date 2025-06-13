import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get set }
    
    func start()
    func showTabController()
    func showLogin()
//    func showChat()
    func showProfile()
    func showRegister()
    func pop()
    func popToRoot()
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension Router {
    func start() {
        showTabController()
    }
    
    func showTabController() {
        let viewController = TabBarController(router: self)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func showLogin() {
        let viewModel = LoginViewModel(router: self)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
//    func showChat() {
//        let viewModel = ChatViewModel(router: self)
//        let viewController = ChatViewController(viewModel: viewModel)
//        navigationController.pushViewController(viewController, animated: true)
//    }
    
    func showProfile() {
        let viewModel = ProfileViewModel(router: self)
        let viewController = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showRegister() {
        let viewModel = RegisterViewModel(router: self)
        let viewController = RegisterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }

    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
