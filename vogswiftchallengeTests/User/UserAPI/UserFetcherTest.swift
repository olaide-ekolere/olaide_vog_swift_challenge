//
//  UserFetcherTest.swift
//  vogswiftchallengeTests
//
//  Created by Olaide Nojeem Ekeolere on 03/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import XCTest

@testable import vogswiftchallenge

class Mocks {
    let authorizationToken = "JHIHWIV8WYFEUBF3BGF3F3FVE"
    
    let invalidResponse = URLResponse(url: URL(string: UserFetcher.url)!,
                                      mimeType: nil,
                                      expectedContentLength: 0,
                                      textEncodingName: nil)
    
    
    let validResponse = HTTPURLResponse(url: URL(string: UserFetcher.url)!,
                                    statusCode: 200,
                                    httpVersion: nil,
                                    headerFields: nil)
    
    let networkError = NSError(domain: "NSURLErrorDomain",
                               code: -1004,
                               userInfo: nil)
}

struct Fixtures {
    static let fetchUserSuccessResponse = """
    {
       "message": "User Retrieved",
       "data":
       {
          "firstName": "Johnny B"
          "userName": "iOS User"
          "lastName": "Goode"
       }
    }
    """
    
}

class UserFetcherTest: XCTestCase {

    var userFetcher: UserFetcher!
    
    var mocks: Mocks!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mocks = Mocks()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        userFetcher = UserFetcher(session: session)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        URLProtocolMock.testURLs = [URL?: Data]()
        URLProtocolMock.response = nil
        URLProtocolMock.error = nil
    }

    func testFetchUserSucceeded() {
        let fetchUserUrl = URL(string: UserFetcher.url)
        URLProtocolMock.testURLs = [fetchUserUrl: Data(Fixtures.fetchUserSuccessResponse.utf8)]
        let publisher = userFetcher.userDetails(withToken: mocks.authorizationToken)
        XCTAssertNotNil(publisher)
        let cancellable = publisher.sink (
          receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssert(false, error.localizedDescription)
            case .finished:
                XCTAssert(true)
            }
          },
          receiveValue: { userResponse in
            XCTAssertNotNil(userResponse)
            XCTAssertEqual(userResponse.message, "User Retrieved")
            XCTAssertEqual(userResponse.data.firstName, "Johnny B")
            XCTAssertEqual(userResponse.data.userName, "iOS User")
            XCTAssertEqual(userResponse.data.lastName, "Goode")
          }
        )
        
        cancellable.cancel()
    }

    func testFetchUserInvalidResponse() {
        let fetchUserUrl = URL(string: UserFetcher.url)
        URLProtocolMock.testURLs = [fetchUserUrl: Data(Fixtures.fetchUserSuccessResponse.utf8)]
        URLProtocolMock.response = mocks.invalidResponse
        let publisher = userFetcher.userDetails(withToken: mocks.authorizationToken)
        XCTAssertNotNil(publisher)
        let cancellable = publisher.sink (
          receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssert(true, error.localizedDescription)
            case .finished:
                XCTAssert(false, "Call should fail")
            }
          },
          receiveValue: { userResponse in
            XCTAssertNil(userResponse, "User response should be null")
          }
        )
        
        cancellable.cancel()
    }

    func testFetchUserInvalidData() {
        let fetchUserUrl = URL(string: UserFetcher.url)
        URLProtocolMock.testURLs = [fetchUserUrl: Data("{{}".utf8)]
        let publisher = userFetcher.userDetails(withToken: mocks.authorizationToken)
        XCTAssertNotNil(publisher)
        let cancellable = publisher.sink (
          receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssert(false, error.localizedDescription)
            case .finished:
                XCTAssert(true)
            }
          },
          receiveValue: { userResponse in
            XCTAssertNil(userResponse, "\(userResponse)")
          }
        )
        
        cancellable.cancel()
    }

    func testFetchUserNetworkFailure() {
        let fetchUserUrl = URL(string: UserFetcher.url)
        URLProtocolMock.testURLs = [fetchUserUrl: Data(Fixtures.fetchUserSuccessResponse.utf8)]
        URLProtocolMock.error = mocks.networkError
        let publisher = userFetcher.userDetails(withToken: mocks.authorizationToken)
        XCTAssertNotNil(publisher)
        let cancellable = publisher.sink (
          receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                XCTAssert(true, error.localizedDescription)
            case .finished:
                XCTAssert(false, "Call should fail")
            }
          },
          receiveValue: { userResponse in
            XCTAssertNil(userResponse, "User response should be null")
          }
        )
        
        cancellable.cancel()
    }

    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    */

}
