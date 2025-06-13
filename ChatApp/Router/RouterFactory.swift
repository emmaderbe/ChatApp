import UIKit

protocol RouterFactoryProtocol {
    func makeRouter() -> RouterProtocol
}

final class RouterFactory: RouterFactoryProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func makeRouter() -> RouterProtocol {
        return Router(navigationController: navigationController)
    }
}

