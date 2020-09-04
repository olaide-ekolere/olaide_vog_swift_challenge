//
//  vogswiftchallengeUITests.swift
//  vogswiftchallengeUITests
//
//  Created by Olaide Nojeem Ekeolere on 02/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import XCTest

class vogswiftchallengeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchSuccess() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        //User Profile loaded successfully
        //let userResponseView = app.otherElements["UserResponseView"]
        //let exists = NSPredicate(format: "exists == 1")
        
        //expectation(for: exists, evaluatedWith: userResponseView, handler: nil)
        //waitForExpectations(timeout: 15, handler: nil)
        
    }

    /*
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    */
}
