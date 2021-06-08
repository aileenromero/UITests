//
//  UserPreferences.swift
//  uitests
//
//  Created by Aileen Romero on 6/8/21.
//

import Foundation
import KeychainSwift

class UserPreferences {
    private class func getPrefs() -> UserDefaults {
        return UserDefaults.standard
    }
    
    class func saveCredentialsToKeychain(username: String, password: String) {
        let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        KeychainSwift().set("Basic \(base64Credentials)", forKey: UserDefaults.Keys.base64Credentials.rawValue)
        KeychainSwift().set(username, forKey: UserDefaults.Keys.username.rawValue)
        KeychainSwift().set(password, forKey: UserDefaults.Keys.password.rawValue)
    }
    
    class func saveCredentialsToKeychain(authToken: String) {
        KeychainSwift().set(authToken, forKey: UserDefaults.Keys.base64Credentials.rawValue)
    }
    
    class func saveUser(_ authUser: User) {
        UserPreferences.setUserId(authUser.id)
        UserPreferences.setUsername(authUser.username)
        UserPreferences.setFirstName(authUser.firstName)
        UserPreferences.setLastName(authUser.lastName)
    }
    
    class func clear() {
        KeychainSwift().clear()
        UserPreferences.setUserId(nil)
        UserPreferences.setUserId(nil)
        UserPreferences.setFirstName(nil)
        UserPreferences.setLastName(nil)
    }
    
    //    USER ID
    private class func setUserId(_ userId: Int?) {
        getPrefs().set(userId, forKey: UserDefaults.Keys.userId.rawValue)
    }
    class func getUserId() -> Int {
        return getPrefs().integer(forKey: UserDefaults.Keys.userId.rawValue)
    }
    //    USERNAME
    private class func setUsername(_ username : String?) {
        getPrefs().set(username, forKey: UserDefaults.Keys.username.rawValue)
    }
    class func getUsername() -> String? {
        return getPrefs().string(forKey: UserDefaults.Keys.username.rawValue)
    }
    //    FIRST NAME
    private class func setFirstName(_ firstName : String?) {
        getPrefs().set(firstName, forKey: UserDefaults.Keys.firstName.rawValue)
    }
    class func getFirstName() -> String? {
        return getPrefs().string(forKey: UserDefaults.Keys.firstName.rawValue)
    }
    //    LAST NAME
    private class func setLastName(_ lastName : String?) {
        getPrefs().set(lastName, forKey: UserDefaults.Keys.lastName.rawValue)
    }
    class func getLastName() -> String? {
        return getPrefs().string(forKey: UserDefaults.Keys.lastName.rawValue)
    }
}
