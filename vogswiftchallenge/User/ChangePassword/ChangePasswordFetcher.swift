//
//  ChangePasswordFetcher.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 05/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//


import Foundation
import Combine

protocol ChangePasswordFetchable {
    func performChangePassword(changePassword: ChangePassword, withToken token: String) -> AnyPublisher<ChangePasswordResponse, UserError>
}

class ChangePasswordFetcher {
    private let session: URLSession
    static let url = "https://api.foo.com/password/change"
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - ChangePasswordFetcher
extension ChangePasswordFetcher: ChangePasswordFetchable {
    func performChangePassword(changePassword: ChangePassword, withToken token: String) -> AnyPublisher<ChangePasswordResponse, UserError> {
        guard let postData = try? JSONEncoder().encode(changePassword) else {
            fatalError("Invalid Post Data")
        }
        var request = URLRequest(url: URL(string: ChangePasswordFetcher.url)!)
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
