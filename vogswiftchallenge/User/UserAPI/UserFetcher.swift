//
//  UserFetcher.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 03/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation
import Combine

protocol UserFetchable {
    func userDetails(withToken token: String) -> AnyPublisher<UserResponse, UserError>
}

class UserFetcher {
    private let session: URLSession
    static let url = "https://api.foo.com/profiles/mine"
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - UserFetcher
extension UserFetcher: UserFetchable {
    func userDetails(withToken token: String) -> AnyPublisher<UserResponse, UserError> {
        var request = URLRequest(url: URL(string: UserFetcher.url)!)
        request.httpMethod = "GET"
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
