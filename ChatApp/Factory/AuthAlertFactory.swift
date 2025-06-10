import UIKit

final class AuthAlertFactory {
    static func present(
        title: String,
        message: String,
        on viewController: UIViewController,
        buttonTitle: String = "Dismiss"
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel))
        viewController.present(alert, animated: true)
    }
}

