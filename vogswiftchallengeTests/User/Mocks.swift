//
//  Mocks.swift
//  vogswiftchallengeTests
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation
import Combine

@testable import vogswiftchallenge

class Mocks {
    let authorizationToken = "JHIHWIV8WYFEUBF3BGF3F3FVE"
    
    let invalidResponse = URLResponse(url: URL(string: Fixtures.url)!,
                                      mimeType: nil,
                                      expectedContentLength: 0,
                                      textEncodingName: nil)
    
    
    let validResponse = HTTPURLResponse(url: URL(string: Fixtures.url)!,
                                    statusCode: 200,
                                    httpVersion: nil,
                                    headerFields: nil)
    
    let networkError = NSError(domain: "NSURLErrorDomain",
                               code: -1004,
                               userInfo: nil)
}

struct Fixtures {
    static let url = "https://api.foo.com/profiles/mine"
    static let updateUrl = "https://api.foo.com/profiles/update"
    static let passwordUrl = "https://api.foo.com/password/change"
    static let fetchUserSuccessResponse = """
    {
       "message": "User Retrieved",
       "data":
       {
          "firstName": "Johnny B",
          "userName": "iOS User",
          "lastName": "Goode"
       }
    }
    """
    static let changePasswordSuccessResponse = """
    {
       "message": "User Retrieved",
       "code": "200"
    }
    """
    
}
