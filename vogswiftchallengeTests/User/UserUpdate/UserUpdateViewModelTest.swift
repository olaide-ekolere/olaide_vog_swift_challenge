//
//  UserUpdateViewModelTest.swift
//  vogswiftchallengeTests
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import XCTest

@testable import vogswiftchallenge

class UserUpdateViewModelTest: XCTestCase {
    
    var mocks: Mocks!
    let userResponse: UserResponse = UserResponse(message: "User Retrieved", data: UserResponse.UserData(firstName: "Johnny B", lastName: "Goode", userName: "iOS User"))
    let userUpdate: UserUpdate = UserUpdate(firstName: "Tracey", lastName: "Chapman")
    let successMessage: String = "User Retrieved"
    let failedMessage: String = "Token has expired"
    override func setUp() {
        mocks = Mocks()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testUpdateSucceeded() {
        let userUpdateFetcher = UserUpdateFetcherMock(message: successMessage)
        let viewModel = UserUpdateViewModel(item: userResponse, userUpdateFetcher: userUpdateFetcher, authorizationToken: mocks.authorizationToken);
        XCTAssertNotNil(viewModel)
        XCTAssertNil(viewModel.dataSource)
        XCTAssert(!viewModel.isLoading)
        
        viewModel.performUserUpdate(userUpdate: userUpdate)
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            XCTAssert(!viewModel.isLoading)
            XCTAssertEqual(viewModel.dataSource!, self.successMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }

    
    func testUpdateFailed() {
        let userUpdateFetcher = UserUpdateFetcherMock(message: failedMessage)
        let viewModel = UserUpdateViewModel(item: userResponse, userUpdateFetcher: userUpdateFetcher, authorizationToken: mocks.authorizationToken);
        XCTAssertNotNil(viewModel)
        XCTAssertNil(viewModel.dataSource)
        XCTAssert(!viewModel.isLoading)
        
        viewModel.performUserUpdate(userUpdate: userUpdate)
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            XCTAssert(!viewModel.isLoading)
            XCTAssertEqual(viewModel.dataSource!, self.failedMessage)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }
}
