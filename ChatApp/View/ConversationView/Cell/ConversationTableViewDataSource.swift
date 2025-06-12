import UIKit

protocol ConversationTableViewDataSourceProtocol: AnyObject {
}

final class ConversationTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var conversations: [Int] = []
    weak var delegate: ConversationTableViewDataSourceProtocol?
    
    func updateChats(_ chats: [Int]) {
        self.conversations = chats
    }
}

extension ConversationTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ConversationViewCell.identifier,
            for: indexPath) as? ConversationViewCell else {
            return UITableViewCell()
        }
//        let conversation = conversations[indexPath.row]
//        cell.configure(with: conversation)
        return cell
    }
}
