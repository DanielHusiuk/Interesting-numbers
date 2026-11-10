import XCTest
@testable import InterestingNumbersLibrary

final class InterestingNumbersLibraryTests: XCTestCase {

    private let manager = MockApiManager()
    private var service: ApiServiceProtocol?
    
    override func setUp() {
        service = ApiService(apiManager: manager)
    }
    
    func testSingleFactIsReturned() {
        manager.result = .success(MockFact.singleFact)
        let completed = expectation(description: "Single fact request completes")

        service?.fetchFacts(for: .number(42), type: .trivia) { result in
            defer { completed.fulfill() }

            guard case .success(let facts) = result else {
                return XCTFail("Expected a successful response.")
            }
            
            XCTAssertEqual(facts.count, 1)
            XCTAssertEqual(facts.first?.number, 42)
            XCTAssertEqual(facts.first?.text, "A fact for unit testing.")
        }
        wait(for: [completed], timeout: 1)
    }
    
    func testFailureIsReturned() {
        manager.result = .failure(URLError(.badServerResponse))
        let completed = expectation(description: "Failed request completes")

        service?.fetchFacts(for: .random, type: .trivia) { result in
            defer { completed.fulfill() }

            guard case .failure(let error) = result else {
                return XCTFail("Expected a failure.")
            }
            
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
        wait(for: [completed], timeout: 1)
    }
    
}
