//
//  UserUpdateFetcher.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation
import Combine

protocol UserUpdateFetchable {
    func performUserUpdate(userUpdate: UserUpdate, withToken token: String) -> AnyPublisher<UserResponse, UserError>
}

class UserUpdateFetcher {
    private let session: URLSession
    static let url = "https://api.foo.com/profiles/update"
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - UserUpdateFetcher
extension UserUpdateFetcher: UserUpdateFetchable {
    func performUserUpdate(userUpdate: UserUpdate, withToken token: String) -> AnyPublisher<UserResponse, UserError> {
        guard let postData = try? JSONEncoder().encode(userUpdate) else {
            fatalError("Invalid Post Data")
        }
        var request = URLRequest(url: URL(string: UserUpdateFetcher.url)!)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.setValue("Authorization", forHTTPHeaderField: "Bearer \(token)")
        return session.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap { pair in
            decode(pair.data)
            
        }
            .eraseToAnyPublisher();
    }
}
