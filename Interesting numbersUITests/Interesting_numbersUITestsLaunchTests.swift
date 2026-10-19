//
//  InterestingNumbersUITestsLaunchTests.swift
//  Interesting numbersUITests
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import XCTest

final class InterestingNumbersUITestsLaunchTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
