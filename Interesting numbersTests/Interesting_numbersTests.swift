//
//  InterestingNumbersTests.swift
//  Interesting numbersTests
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import XCTest
@testable import Interesting_numbers

final class InterestingNumbersTests: XCTestCase {
    
    private let manager = MockApiManager()
    private var service: ApiServiceProtocol?

    override func setUp() {
        service = ApiService(apiManager: manager)
    }

    func testSingleFactIsReturned() {
        manager.result = .success(MockFact.singleFact)

        service?.fetchFacts(for: .number(42), type: .trivia) { result in
            guard case .success(let facts) = result else {
                return XCTFail("Expected a successful response.")
            }

            XCTAssertEqual(facts.count, 1)
            XCTAssertEqual(facts.first?.number, 42)
            XCTAssertEqual(facts.first?.text, "A fact for unit testing.")
        }
    }

    func testFailureIsReturned() {
        manager.result = .failure(URLError(.badServerResponse))

        service?.fetchFacts(for: .random, type: .trivia) { result in
            guard case .failure(let error) = result else {
                return XCTFail("Expected a failure.")
            }

            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
    }
}
