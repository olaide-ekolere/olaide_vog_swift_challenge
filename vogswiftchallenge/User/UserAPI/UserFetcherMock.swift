//
//  MockUserFetcher.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation
import Combine

class UserFetcherMock : UserFetchable{
    let data: Data
    init(data: Data) {
        self.data = data
    }
    func userDetails(withToken token: String) -> AnyPublisher<UserResponse, UserError> {
        let decoder = JSONDecoder()
           decoder.dateDecodingStrategy = .secondsSince1970
        //UserFetcherMock.data = Data()
        //print(UserFetcherMock.data!)
        return Just(self.data)
            .decode(type: UserResponse.self, decoder: decoder)
            .mapError{error in
                .parsing(description: "\(error.localizedDescription)")
        }
        .eraseToAnyPublisher()
        /*
        return Just(UserFetcherMock.data!)
            .mapError { error in
                           .network(description: error.localizedDescription)
            }
            .flatMap { pair in
                decode(pair)
                
            }
        .eraseToAnyPublisher()
        */
    }
}
