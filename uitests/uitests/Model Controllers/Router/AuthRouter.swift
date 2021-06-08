//
//  AuthRouter.swift
//  App
//
//  Created by Aileen Romero on 6/8/21.
//  Copyright © 2021 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift

enum AuthRouter: URLRequestConvertible {
    
    case login(username: String?, password: String?)
    
    private var baseURLString: String {
        return Server.getBaseURL().rawValue
    }
    
    private var method: HTTPMethod {
        switch self {
        case .login: return .post
        }
    }
    
    private var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            if let base64Credentials = (KeychainSwift().get(UserDefaults.Keys.base64Credentials.rawValue)) {
                urlRequest.setValue(base64Credentials, forHTTPHeaderField: "Authorization")
            }
        
        
        switch self {
        case .login(let params):
            if let username = params.username, let password = params.password {
                let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8)!
                let base64Credentials = credentialData.base64EncodedString(options: [])
                urlRequest.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
            } else if let base64Credentials = (KeychainSwift().get(UserDefaults.Keys.base64Credentials.rawValue)) {
                urlRequest.setValue(base64Credentials, forHTTPHeaderField: "Authorization")
            }
        }
        return urlRequest
    }
    
}
