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
        
        //Page title exists
        let title = app.navigationBars.staticTexts["User Profile"]
        XCTAssertTrue(title.exists)
        
        //Edit Profile loaded successfully
        let editTitle = app.staticTexts["BASIC INFORMATION"]
        _ = editTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(editTitle.exists)
        
        //Change Password loaded successfully
        let passwordTitle = app.staticTexts["PASSWORD"]
        XCTAssertTrue(passwordTitle.exists)
    }

    func testLaunchFailed() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["failed-user-profile"]
        app.launch()
        
        //Page title exists
        let title = app.navigationBars.staticTexts["User Profile"]
        XCTAssertTrue(title.exists)
        
        //Error message shown
        let errorTitle = app.staticTexts["profile-error-text"]
        _ = errorTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(errorTitle.exists)
        
        //Edit Profile did not load
        let editTitle = app.staticTexts["BASIC INFORMATION"]
        XCTAssertTrue(!editTitle.exists)
        
        //Change Password did not load
        let passwordTitle = app.staticTexts["PASSWORD"]
        XCTAssertTrue(!passwordTitle.exists)
        
        
        //Retry button is visible
        let retryButton = app.buttons["profile-retry-button"]
        XCTAssertTrue(retryButton.exists)
        
        //Cant tap the retry button
        retryButton.tap()
    }
    
    //func testEditDetailsValidation

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
