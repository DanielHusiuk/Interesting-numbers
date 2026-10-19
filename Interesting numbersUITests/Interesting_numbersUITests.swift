//
//  InterestingNumbersUITests.swift
//  Interesting numbersUITests
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import XCTest

final class InterestingNumbersUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
