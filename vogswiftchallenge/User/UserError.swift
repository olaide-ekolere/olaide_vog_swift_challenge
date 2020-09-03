//
//  UserError.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 02/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation

enum UserError: Error {
    case parsing(description: String)
    case network(description: String)
}
