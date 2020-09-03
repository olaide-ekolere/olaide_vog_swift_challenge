//
//  Parsing.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 03/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, UserError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError{error in
            .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
