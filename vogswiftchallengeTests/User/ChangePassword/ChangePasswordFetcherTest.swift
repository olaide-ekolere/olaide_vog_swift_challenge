//
//  ChangePasswordFetcherTest.swift
//  vogswiftchallengeTests
//
//  Created by Olaide Nojeem Ekeolere on 05/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import XCTest

@testable import vogswiftchallenge

class ChangePasswordFetcherTest: XCTestCase {

    
    var changePasswordFetcher: ChangePasswordFetchable!
    var changePassword: ChangePassword!
    
    var mocks: Mocks!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mocks = Mocks()
        self.changePassword = ChangePassword(currentPassword: "oldpassword", newPassword: "newpassword", confirmPassword: "newpassword")
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        changePasswordFetcher = ChangePasswordFetcher(session: session)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        URLProtocolMock.testURLs = [URL?: Data]()
        URLProtocolMock.response = nil
        URLProtocolMock.error = nil
    }
    

    func testChangePasswordSucceeded() {
        let passwordUrl = URL(string: Fixtures.passwordUrl)
        URLProtocolMock.testURLs = [passwordUrl: Data(Fixtures.changePasswordSuccessResponse.utf8)]
        let publisher = changePasswordFetcher.performChangePassword(changePassword: self.changePassword, withToken: mocks.authorizationToken)
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
          receiveValue: { changePasswordResponse in
            XCTAssertNotNil(changePasswordResponse)
            XCTAssertEqual(changePasswordResponse.message, "Password Changed")
            XCTAssertEqual(changePasswordResponse.code, "200")
          }
        )
        
        cancellable.cancel()
    }
    

    func testChangePasswordInvalidResponse() {
        let passwordUrl = URL(string: Fixtures.passwordUrl)
        URLProtocolMock.testURLs = [passwordUrl: Data(Fixtures.changePasswordSuccessResponse.utf8)]
        URLProtocolMock.response = mocks.invalidResponse
        let publisher = changePasswordFetcher.performChangePassword(changePassword: self.changePassword, withToken: mocks.authorizationToken)
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
          receiveValue: { changePasswordResponse in
            XCTAssertNil(changePasswordResponse, "Response should be null")
          }
        )
        
        cancellable.cancel()
    }
    

    func testChangePasswordInvalidData() {
        let passwordUrl = URL(string: Fixtures.passwordUrl)
        URLProtocolMock.testURLs = [passwordUrl: Data("{{}".utf8)]
        let publisher = changePasswordFetcher.performChangePassword(changePassword: self.changePassword, withToken: mocks.authorizationToken)
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
          receiveValue: { changePasswordResponse in
            XCTAssertNil(changePasswordResponse, "\(changePasswordResponse)")
          }
        )
        
        cancellable.cancel()
    }
    

    func testChangePasswordNetworkFailure() {
        let passwordUrl = URL(string: Fixtures.passwordUrl)
        URLProtocolMock.testURLs = [passwordUrl: Data("{{}".utf8)]
        URLProtocolMock.error = mocks.networkError
        let publisher = changePasswordFetcher.performChangePassword(changePassword: self.changePassword, withToken: mocks.authorizationToken)
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
          receiveValue: { changePasswordResponse in
            XCTAssertNil(changePasswordResponse, "\(changePasswordResponse)")
          }
        )
        
        cancellable.cancel()
    }
}
