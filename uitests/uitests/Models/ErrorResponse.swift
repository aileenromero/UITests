//
//  ErrorResponse.swift
//  uitests
//
//  Created by Aileen Romero on 6/8/21.
//

import Foundation

struct ErrorResponse: Codable {
    
    var httpCode: Int
    var errorCode: String?
    var message: String?
    
}
