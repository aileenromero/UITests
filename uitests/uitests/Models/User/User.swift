//
//  User.swift
//  uitests
//
//  Created by Aileen Romero on 6/8/21.
//

import Foundation

struct User: Codable {
    var id: Int
    var firstName: String?
    var lastName: String?
    var username: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case username = "username"
    }
}
