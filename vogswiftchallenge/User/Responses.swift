//
//  Responses.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 02/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let message: String
    let data: UserData
    init() {
        message = "User Retrieved"
        data = UserData()
    }
    struct UserData: Codable {
        init() {
            firstName = "olaide"
            lastName = "ekeolere"
            userName = "iOS"
        }
        let firstName: String
        let userName: String
        let lastName: String
    }
}
