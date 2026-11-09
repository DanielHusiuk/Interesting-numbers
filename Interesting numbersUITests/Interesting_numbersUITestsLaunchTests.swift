//
//  InterestingNumbersUITestsLaunchTests.swift
//  Interesting numbersUITests
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import XCTest

final class InterestingNumbersUITestsLaunchTests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uiTesting"]
        app.launch()
        
        XCTAssertTrue(
            app.textFields["main.numberTextField"].waitForExistence(timeout: 2),
            "The main screen did not appear."
        )
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    @MainActor
    func testMainScreenElementsExist() {
        XCTAssertTrue(app.buttons["main.segment.0"].exists)
        XCTAssertTrue(app.buttons["main.segment.1"].exists)
        XCTAssertTrue(app.buttons["main.segment.2"].exists)
        XCTAssertTrue(app.buttons["main.segment.3"].exists)
        XCTAssertTrue(app.buttons["main.displayFactButton"].exists)
    }
    
    @MainActor
    func testInvalidSingleNumber() {
        let displayButton = app.buttons["main.displayFactButton"]
        displayButton.tap()
        
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.waitForExistence(timeout: 2))
        XCTAssertTrue(alert.staticTexts["Enter a number first."].exists)
        alert.buttons["OK"].tap()
        XCTAssertFalse(alert.exists)
    }
    
    @MainActor
    func testSuccessfulRequest() {
        let textField = app.textFields["main.numberTextField"]
        textField.tap()
        textField.typeText("42")
        app.buttons["main.displayFactButton"].tap()
        
        let detailTitle = app.staticTexts["detail.titleLabel"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 2))
        XCTAssertEqual(detailTitle.label, "42")
        XCTAssertEqual(
            app.staticTexts["detail.factLabel"].label,
            "A fact for UI testing."
        )
        
        app.buttons["detail.closeButton"].tap()
        XCTAssertTrue(textField.waitForExistence(timeout: 2))
    }
}
