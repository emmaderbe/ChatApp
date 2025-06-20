import UIKit

extension UIView {
    var width: CGFloat { return frame.size.width }
    var height: CGFloat { return frame.size.height }
}

extension UIView {
    func observeKeyboard(for scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
            guard let keyboardFrame = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            scrollView.contentInset.bottom = keyboardFrame.height + 16
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            scrollView.contentInset.bottom = 0
        }
    }
}
