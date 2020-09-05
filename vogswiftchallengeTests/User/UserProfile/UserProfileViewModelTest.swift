//
//  UserProfileViewModelTest.swift
//  vogswiftchallengeTests
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import XCTest

@testable import vogswiftchallenge

class UserProfileViewModelTest: XCTestCase {


    
    var mocks: Mocks!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mocks = Mocks()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    

    func testFetchSucceeded() {
        let userFetcher = UserFetcherMock(data: Data(Fixtures.fetchUserSuccessResponse.utf8))
        let viewModel = UserProfileViewModel(userFetcher: userFetcher, authorizationToken: mocks.authorizationToken);
        XCTAssertNotNil(viewModel)
        XCTAssertNil(viewModel.dataSource)
        XCTAssert(!viewModel.failed)
        
        viewModel.fetchUserProfile()
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            XCTAssert(!viewModel.failed)
            XCTAssertNotNil(viewModel.dataSource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }

    

    func testFetchFailed() {
        let userFetcher = UserFetcherMock(data: Data("".utf8))
        let viewModel = UserProfileViewModel(userFetcher: userFetcher, authorizationToken: mocks.authorizationToken);
        XCTAssertNotNil(viewModel)
        XCTAssertNil(viewModel.dataSource)
        XCTAssert(!viewModel.failed)
        
        viewModel.fetchUserProfile()
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            XCTAssert(viewModel.failed)
            XCTAssertNil(viewModel.dataSource)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }
}
