//
//  DefaultRouter.swift
//  uitestsUITests
//
//  Created by Aileen Romero on 6/8/21.
//

import Foundation
import Embassy
import EnvoyAmbassador

class DefaultRouter: Router {
    
    // MARK: - Auth
    
    static let loginPath = "/login"
    
    // MARK: - Instance
    
    override init() {
        super.init()
     
        self[DefaultRouter.loginPath] = JSONResponse() { _ -> Any in
            return self.getUserJSONResponse()
        }
    }
    
    func getUserJSONResponse() -> [String: Any?] {
        return [
            "user_id": 1,
            "username": "aileenromero",
            "first_name": "Aileen",
            "last_name": "Romero"
        ]
    }
}
