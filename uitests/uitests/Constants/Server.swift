//
//  Server.swift
//  App
//
//  Created by Aileen Romero on 6/8/21.
//  Copyright © 2021 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import Foundation

enum Server: String {
    
    case mock = "https://private-a808f-uitestsexample.apiary-mock.com"
    case localhost = "http://localhost:8080/api"
    
    static func getBaseURL() -> Server {
        let isInTestMode = ProcessInfo.processInfo.environment["IS_UI_TEST_MODE"] != nil
        if isInTestMode {
            return Server.localhost
        } else {
            return Server.mock
        }
    }
    
}
