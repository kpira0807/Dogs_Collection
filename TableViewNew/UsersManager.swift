import Foundation
typealias UserCredential = (email: String, password: String)

class UsersManager {
    static let shared = UsersManager(with: UserDefaults.standard)
    private let userDefaults: UserDefaults
    
    enum LocalConstant {
        static let users: String = "UsersDefaultsKey"
        static let email: String = "email"
        static let password: String = "Password"
    }
    
    init(with userDefaults: UserDefaults){
        self.userDefaults = userDefaults
    }
    
    func getUserCred(with email: String) -> UserCredential? {
        guard let users = userDefaults.object(forKey: LocalConstant.users) as? [[String: String]] else {
            return nil
        }
        
        var userData: UserCredential?
        users.forEach { userCred in
            if userCred[LocalConstant.email] == email, let password = userCred[LocalConstant.password] {
                userData = (email: email, password: password)
            }
        }
        
        return userData
    }
    
    func saveUser(with email: String, password: String) {
        let user = [LocalConstant.email: email, LocalConstant.password: password]
        guard var users = userDefaults.object(forKey: LocalConstant.users) as? [[String: String]] else {
            userDefaults.set([user], forKey: LocalConstant.users)
            return
        }
        
        users.append(user)
        userDefaults.set(users, forKey: LocalConstant.users)
    }
}
