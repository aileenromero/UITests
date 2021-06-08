//
//  AuthUITest.swift
//  uitestsUITests
//
//  Created by Aileen Romero on 6/8/21.
//

import XCTest
import Embassy
import EnvoyAmbassador

class AuthUITest: UITestBase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchEnvironment["UI_TEST_DISABLE_AUTO_SIGN_IN"] = "1"
        app.launch()
        addUIInterruptions()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testInvalidCredentials() {
        router[DefaultRouter.loginPath] = DataResponse(statusCode: 401, statusMessage: "Invalid credentials")
        let usernameField = app.textFields["Username"]
        XCTAssertTrue(usernameField.waitForExistence(timeout: 5))
        usernameField.tap()
        usernameField.typeText("aileenromero")
        let passwordField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5))
        passwordField.tap()
        passwordField.typeText("12345")
        let signInButton = app.buttons["Login"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 5))
        signInButton.tap()
        sleep(5)
        XCTAssert(app.alerts.element.staticTexts["The username or password you entered is incorrect."].exists)
    }

    func testLogin() {
        let usernameField = app.textFields["Username"]
        XCTAssertTrue(usernameField.waitForExistence(timeout: 5))
        usernameField.tap()
        usernameField.typeText("aileenromero")
        let passwordField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5))
        passwordField.tap()
        passwordField.typeText("romero")
        let signInButton = app.buttons["Login"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 5))
        signInButton.tap()
        sleep(5)
    }
}
