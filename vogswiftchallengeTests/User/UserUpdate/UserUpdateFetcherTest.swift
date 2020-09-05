//
//  UserUpdateFetcherTest.swift
//  vogswiftchallengeTests
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import XCTest

@testable import vogswiftchallenge

class UserUpdateFetcherTest: XCTestCase {
    var userUpdateFetcher: UserUpdateFetchable!
    var userUpdate: UserUpdate!
    
    var mocks: Mocks!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mocks = Mocks()
        self.userUpdate = UserUpdate(firstName: "Johnny B", lastName: "Goode")
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        userUpdateFetcher = UserUpdateFetcher(session: session)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        URLProtocolMock.testURLs = [URL?: Data]()
        URLProtocolMock.response = nil
        URLProtocolMock.error = nil
    }

    func testUserUpdateSucceeded() {
        let userUpdateUrl = URL(string: Fixtures.updateUrl)
        URLProtocolMock.testURLs = [userUpdateUrl: Data(Fixtures.fetchUserSuccessResponse.utf8)]
        let publisher = userUpdateFetcher.performUserUpdate(userUpdate: self.userUpdate, withToken: mocks.authorizationToken)
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

    func testUserUpdateInvalidResponse() {
        let userUpdateUrl = URL(string: Fixtures.updateUrl)
        URLProtocolMock.testURLs = [userUpdateUrl: Data(Fixtures.fetchUserSuccessResponse.utf8)]
        URLProtocolMock.response = mocks.invalidResponse
        let publisher = userUpdateFetcher.performUserUpdate(userUpdate: self.userUpdate, withToken: mocks.authorizationToken)
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

    func testUserUpdateInvalidData() {
        let userUpdateUrl = URL(string: Fixtures.updateUrl)
        URLProtocolMock.testURLs = [userUpdateUrl: Data("{{}".utf8)]
        let publisher = userUpdateFetcher.performUserUpdate(userUpdate: self.userUpdate, withToken: mocks.authorizationToken)
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

    func testUserUpdateNetworkFailure() {
        let userUpdateUrl = URL(string: Fixtures.updateUrl)
        URLProtocolMock.testURLs = [userUpdateUrl: Data(Fixtures.fetchUserSuccessResponse.utf8)]
        URLProtocolMock.error = mocks.networkError
        let publisher = userUpdateFetcher.performUserUpdate(userUpdate: self.userUpdate, withToken: mocks.authorizationToken)
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

}
