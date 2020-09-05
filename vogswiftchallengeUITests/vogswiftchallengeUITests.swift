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
        
        //Retry button is visible
        let retryButton = app.buttons["profile-retry-button"]
        XCTAssertTrue(retryButton.exists)
        
        //Cant tap the retry button
        retryButton.tap()
    }
    
    func testDetailsValidation(){
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
        
        
        //Username title exists
        let userNameTitle = app.staticTexts["Username"]
        XCTAssertTrue(userNameTitle.exists)
        
        //First Name title exists
        let firstNameTitle = app.staticTexts["First Name"]
        XCTAssertTrue(firstNameTitle.exists)
        
        //Last Name title exists
        let lastNameTitle = app.staticTexts["Last Name"]
        XCTAssertTrue(lastNameTitle.exists)
        
        
        //Current Password title exists
        let currentTitle = app.staticTexts["Current Password"]
        XCTAssertTrue(currentTitle.exists)
        
        //New Password title exists
        let newTitle = app.staticTexts["New Password"]
        XCTAssertTrue(newTitle.exists)
        
        //Confirm password title exists
        let reTitle = app.staticTexts["Re-enter Password"]
        XCTAssertTrue(reTitle.exists)
        
    }

    func testFirstNameValidation(){
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
        
        //First name field exists
        let firstNameField = app.textFields["first-name-field"]
        XCTAssertTrue(firstNameField.exists)
        
        //Message label
        let messageLabel = app.staticTexts["update-message"]
        XCTAssertTrue(messageLabel.exists)
               
        //Save changes button exists
        let saveButton = app.buttons["update-profile-button"]
        XCTAssertTrue(saveButton.exists)
               
        //Clear first name field
        firstNameField.tap()
        for _ in 1...10 {
            firstNameField.typeText(XCUIKeyboardKey.delete.rawValue)
        }
        //press saveButton
        saveButton.tap()
               
        //verify first name validation
        let valueTitle = app.staticTexts["First Name must be at least 4 characters"]
        _ = valueTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(valueTitle.exists)
               
    }

    func testLastNameValidation(){
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
        
        //Last name field exists
        let lastNameField = app.textFields["last-name-field"]
        XCTAssertTrue(lastNameField.exists)
        
        //Message label
        let messageLabel = app.staticTexts["update-message"]
        XCTAssertTrue(messageLabel.exists)
               
        //Save changes button exists
        let saveButton = app.buttons["update-profile-button"]
        XCTAssertTrue(saveButton.exists)
               
        //Clear first name field
        lastNameField.tap()
        for _ in 1...10 {
            lastNameField.typeText(XCUIKeyboardKey.delete.rawValue)
        }
        //press saveButton
        saveButton.tap()
               
        //verify last name validation
        let valueTitle = app.staticTexts["Last Name must be at least 4 characters"]
        _ = valueTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(valueTitle.exists)
               
    }
    
    func testUpdateSuccessfully(){
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
        
        //Save changes button exists
        let saveButton = app.buttons["update-profile-button"]
        XCTAssertTrue(saveButton.exists)
        
        //tap to save
        saveButton.tap()
        //Edit Profile successfully
        let valueTitle = app.staticTexts["Updated Successfully"]
        _ = valueTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(valueTitle.exists)
    }
    
    func testUpdateFailed(){
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["failed-user-update"]
        app.launch()
                      
        //Page title exists
        let title = app.navigationBars.staticTexts["User Profile"]
        XCTAssertTrue(title.exists)
                      
        //Edit Profile loaded successfully
        let editTitle = app.staticTexts["BASIC INFORMATION"]
        _ = editTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(editTitle.exists)
        
        //Save changes button exists
        let saveButton = app.buttons["update-profile-button"]
        XCTAssertTrue(saveButton.exists)
        
        //tap to save
        saveButton.tap()
        //Edit Profile successfully
        let valueTitle = app.staticTexts["Session has expired"]
        _ = valueTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(valueTitle.exists)
    }
    
    

    func testCurrentPasswordValidation(){
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
               
        //Page title exists
        let title = app.navigationBars.staticTexts["User Profile"]
        XCTAssertTrue(title.exists)
               
        //Edit Profile loaded successfully
        let passwordTitle = app.staticTexts["PASSWORD"]
        _ = passwordTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(passwordTitle.exists)
        
        //Current Password field exists
        let currentPasswordField = app.secureTextFields["current-password-field"]
        XCTAssertTrue(currentPasswordField.exists)
        
               
        //Save changes button exists
        let saveButton = app.buttons["change-password-button"]
        XCTAssertTrue(saveButton.exists)
               
        //press saveButton
        saveButton.tap()
               
        //verify first name validation
        let valueTitle = app.staticTexts["Current password must be at least 4 characters"]
        _ = valueTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(valueTitle.exists)
               
    }

    func testNewPasswordValidation(){
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
               
        //Page title exists
        let title = app.navigationBars.staticTexts["User Profile"]
        XCTAssertTrue(title.exists)
               
        //Edit Profile loaded successfully
        let passwordTitle = app.staticTexts["PASSWORD"]
        _ = passwordTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(passwordTitle.exists)
        
        //Current Password field exists
        let currentPasswordField = app.secureTextFields["current-password-field"]
        XCTAssertTrue(currentPasswordField.exists)
        
        //New Password field exists
        let newPasswordField = app.secureTextFields["new-password-field"]
        XCTAssertTrue(newPasswordField.exists)
        
        //enter current password
        currentPasswordField.tap()
        currentPasswordField.typeText("Olaide")
        
        //Save changes button exists
        let saveButton = app.buttons["change-password-button"]
        XCTAssertTrue(saveButton.exists)
               
        //press saveButton
        saveButton.tap()
               
        //verify first name validation
        let valueTitle = app.staticTexts["New Password must be at least 4 characters"]
        _ = valueTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(valueTitle.exists)
               
    }

    func testConfirmPasswordValidation(){
        continueAfterFailure = false
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["filled-password"]
        app.launch()
               
        //Page title exists
        let title = app.navigationBars.staticTexts["User Profile"]
        XCTAssertTrue(title.exists)
               
        //Edit Profile loaded successfully
        let passwordTitle = app.staticTexts["PASSWORD"]
        _ = passwordTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(passwordTitle.exists)
        
        //Confirm Password field exists
        let confirmPasswordField = app.secureTextFields["confirm-password-field"]
        XCTAssertTrue(confirmPasswordField.exists)
        
        
        //Save changes button exists
        let saveButton = app.buttons["change-password-button"]
        XCTAssertTrue(saveButton.exists)
        
        //press saveButton
        saveButton.tap()
        

        //verify first name validation
        let valueTitle = app.staticTexts["Re-enter Password not match New Password"]
        _ = valueTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(valueTitle.exists)
        
        confirmPasswordField.tap()
        confirmPasswordField.typeText("confirmpassword\n")
        sleep(2)
               //press saveButton
        saveButton.tap()
        _ = valueTitle.waitForExistence(timeout: 2)
        XCTAssertTrue(valueTitle.exists)
    }

    func testChangePasswordSuccessfull(){
        continueAfterFailure = false
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["filled-password"]
        app.launch()
               
        //Page title exists
        let title = app.navigationBars.staticTexts["User Profile"]
        XCTAssertTrue(title.exists)
               
        //Edit Profile loaded successfully
        let passwordTitle = app.staticTexts["PASSWORD"]
        _ = passwordTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(passwordTitle.exists)
        
        //Confirm Password field exists
        let confirmPasswordField = app.secureTextFields["confirm-password-field"]
        XCTAssertTrue(confirmPasswordField.exists)
        
        
        //Save changes button exists
        let saveButton = app.buttons["change-password-button"]
        XCTAssertTrue(saveButton.exists)
        
        confirmPasswordField.tap()
        confirmPasswordField.typeText("newpassword\n")
        sleep(2)
        //press saveButton
        saveButton.tap()
        

        //verify first name validation
        let valueTitle = app.staticTexts["Password Changed"]
        _ = valueTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(valueTitle.exists)
               
    }

    func testChangePasswordFailed(){
        continueAfterFailure = false
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["failed-change-password"]
        app.launch()
               
        //Page title exists
        let title = app.navigationBars.staticTexts["User Profile"]
        XCTAssertTrue(title.exists)
               
        //Edit Profile loaded successfully
        let passwordTitle = app.staticTexts["PASSWORD"]
        _ = passwordTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(passwordTitle.exists)
        
        //Confirm Password field exists
        let confirmPasswordField = app.secureTextFields["confirm-password-field"]
        XCTAssertTrue(confirmPasswordField.exists)
        
        
        //Save changes button exists
        let saveButton = app.buttons["change-password-button"]
        XCTAssertTrue(saveButton.exists)
        
        confirmPasswordField.tap()
        confirmPasswordField.typeText("newpassword\n")
        sleep(2)
        //press saveButton
        saveButton.tap()
        

        //verify first name validation
        let valueTitle = app.staticTexts["Invalid Old Password"]
        _ = valueTitle.waitForExistence(timeout: 5)
        
        XCTAssertTrue(valueTitle.exists)
               
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
