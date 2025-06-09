import Foundation
import FirebaseDatabase

final class DataBaseManager {
    static let shared = DataBaseManager()
    private let database = Database.database().reference()
}

extension DataBaseManager {
    public func userExist(with email: String, complition: @escaping ((Bool) -> Void)) {
        let safeEmail = email.safeDatabaseKey
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                complition(false)
            } else {
                complition(true)
            }
        }
    }
}

extension DataBaseManager {
    public func insertUser(with user: ChatAppUser) {
        let safeEmail = user.emailAddress.safeDatabaseKey

        database.child(safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
}
