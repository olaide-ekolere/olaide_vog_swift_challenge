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
    let data: Data
    
    struct Data: Codable {
        let firstName: String
        let userName: String
        let lastName: String
    }
}
