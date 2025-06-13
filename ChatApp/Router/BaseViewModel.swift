import Foundation

protocol BaseViewModelProtocol {
    var router: RouterProtocol { get }
}

class BaseViewModel: BaseViewModelProtocol {
    let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }
}
