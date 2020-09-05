//
//  ChangePasswordFetcherMock.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 05/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation
import Combine

class ChangePasswordFetcherMock : ChangePasswordFetchable{
    let message: String
    let code: String
    let networkError: Bool
    init(message: String, code: String, networkError: Bool = false) {
        self.message = message
        self.code = code
        self.networkError = networkError
    }
    func performChangePassword(changePassword: ChangePassword, withToken token: String) -> AnyPublisher<ChangePasswordResponse, UserError> {
        let decoder = JSONDecoder()
           decoder.dateDecodingStrategy = .secondsSince1970
        //UserFetcherMock.data = Data()
        //print(UserFetcherMock.data!)
        let changePasswordResponse = ChangePasswordResponse(code: self.code, message: self.message)
        return Just(changePasswordResponse)
        .encode(encoder: JSONEncoder())
            .decode(type: ChangePasswordResponse.self, decoder: decoder)
            .mapError{error in
                .parsing(description: "\(error.localizedDescription)")
        }
        .eraseToAnyPublisher()
    }
}
