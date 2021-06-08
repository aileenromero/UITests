//
//  AuthServices.swift
//  uitests
//
//  Created by Aileen Romero on 6/8/21.
//

import Foundation

class AuthServices: BaseServices {
    
    // MARK: - Stored
    
    static let shared = AuthServices()
    
    // MARK: - Initialization
    
    private init() {
        
    }
    
    // MARK: - Instance
    func login(username: String?, password: String?, completion: @escaping (User?, Error?) -> Void) {
        genericNetworkRequest(urlRequest: AuthRouter.login(username: username, password: password), completion: completion)
    }
}
