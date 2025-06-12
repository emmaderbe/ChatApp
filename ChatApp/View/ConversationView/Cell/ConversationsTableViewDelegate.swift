import UIKit

protocol ConversationTableViewDelegateProtocol: AnyObject {
    func didSelectTask(at index: Int)
}

final class ConversationsTableViewDelegate: NSObject, UITableViewDelegate {
    
    private var conversations: [Int] = []
    weak var delegate: ConversationTableViewDelegateProtocol?
    
    func updateChats(_ chats: [Int]) {
        self.conversations = chats
    }
}

extension ConversationsTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectTask(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
