//
//  ChangePasswordViewModelTest.swift
//  vogswiftchallengeTests
//
//  Created by Olaide Nojeem Ekeolere on 05/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import XCTest

@testable import vogswiftchallenge

class ChangePasswordViewModelTest: XCTestCase {
    
    var mocks: Mocks!
    let changePassword:ChangePassword = ChangePassword(currentPassword: "oldpassword", newPassword: "newpassword", confirmPassword: "newpassword")
    let successMessage: String = "Password Changed"
    let successCode: String = "200"
    let failedMessage: String = "Token has expired"
    override func setUp() {
        mocks = Mocks()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testChangeSucceeded() {
        let changePasswordFetcher = ChangePasswordFetcherMock(message: successMessage, code: successCode)
        let viewModel = ChangePasswordViewModel(changePasswordFetcher: changePasswordFetcher, authorizationToken: mocks.authorizationToken);
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.dataSource.count, 0)
        XCTAssert(!viewModel.isLoading)
        
        viewModel.performChangePassword(changePassword: changePassword)
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            XCTAssert(!viewModel.isLoading)
            XCTAssertEqual(viewModel.code, self.successCode)
            XCTAssertEqual(viewModel.dataSource, self.successMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }

    
    func testChangeFailed() {
        let changePasswordFetcher = ChangePasswordFetcherMock(message: failedMessage, code: "400")
        let viewModel = ChangePasswordViewModel(changePasswordFetcher: changePasswordFetcher, authorizationToken: mocks.authorizationToken);
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.dataSource.count, 0)
        XCTAssert(!viewModel.isLoading)
        
        viewModel.performChangePassword(changePassword: changePassword)
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            XCTAssert(!viewModel.isLoading)
            XCTAssertNotEqual(viewModel.code, self.successCode)
            XCTAssertNotEqual(viewModel.dataSource, self.successMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }

}
