import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var router: RouterProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let routerFactory = RouterFactory(navigationController: navigationController)
        router = routerFactory.makeRouter()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        router?.start()
    }
}

