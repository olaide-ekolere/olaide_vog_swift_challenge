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
    init(message: String, data: UserData) {
        self.message = message
        self.data = data
    }
    struct UserData: Codable {
        init(firstName: String, lastName: String, userName: String) {
            self.firstName = firstName
            self.lastName = lastName
            self.userName = userName
        }
        let firstName: String
        let userName: String
        let lastName: String
    }
}
