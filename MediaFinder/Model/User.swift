//
//  User.swift
//  constranints
//
//  Created by Mohamed Abdelhamed Ahmed on 12/24/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import Foundation

enum Gender: String, Codable {
    case male = "Male", female = "Female"
}

struct User: Codable {
    var name: String!
    var email: String!
    var address: String!
    var password: String!
    var phoneNumber: String!
    var gender: Gender!
}
