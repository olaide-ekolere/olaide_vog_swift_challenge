//
//  ChangePassword.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 05/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation

struct ChangePassword: Codable {
    let currentPassword: String
    let newPassword: String
    let confirmPassword: String
    init(currentPassword: String, newPassword: String, confirmPassword: String) {
        self.currentPassword = currentPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
    }
}
