//
//  UserUpdateFetcherMock.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//


import Foundation
import Combine

class UserUpdateFetcherMock : UserUpdateFetchable{
    let message: String
    let networkError: Bool
    init(message: String, networkError: Bool = false) {
        self.message = message
        self.networkError = networkError
    }
    func performUserUpdate(userUpdate: UserUpdate, withToken token: String) -> AnyPublisher<UserResponse, UserError> {
        let decoder = JSONDecoder()
           decoder.dateDecodingStrategy = .secondsSince1970
        //UserFetcherMock.data = Data()
        //print(UserFetcherMock.data!)
        let userResponse = UserResponse(message: self.message, data: UserResponse.UserData(firstName: userUpdate.firstName, lastName: userUpdate.lastName, userName: "userName"))
        return Just(userResponse)
        .encode(encoder: JSONEncoder())
            .decode(type: UserResponse.self, decoder: decoder)
            .mapError{error in
                .parsing(description: "\(error.localizedDescription)")
        }
        .eraseToAnyPublisher()
    }
}

