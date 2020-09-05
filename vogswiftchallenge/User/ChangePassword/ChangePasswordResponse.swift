//
//  ChangePasswordResponse.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 05/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation

struct ChangePasswordResponse: Codable {
    let code: String
    let message: String
    init(code: String, message: String) {
        self.code = code
        self.message = message
    }
}
