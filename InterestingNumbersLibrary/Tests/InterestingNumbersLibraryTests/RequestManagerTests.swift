import XCTest
@testable import InterestingNumbersLibrary

final class RequestManagerTests: XCTestCase {

    func testSingleNumber() throws {
        let request = try RequestManager.makeRequest(mode: .single, inputText: "42 ")

        guard case .number(let number) = request else {
            return XCTFail("Expected a single-number request.")
        }
        XCTAssertEqual(number, 42)
    }
    
    func testRandomNumber() throws {
        let request = try RequestManager.makeRequest(mode: .random, inputText: nil)
        
        guard case .random = request else {
            return XCTFail("Expected a random request.")
        }
    }

    func testNumberRange() throws {
        let request = try RequestManager.makeRequest(mode: .range, inputText: "3-10")

        guard case .range(let start, let end) = request else {
            return XCTFail("Expected a range request.")
        }
        XCTAssertEqual(start, 3)
        XCTAssertEqual(end, 10)
    }

    func testMultipleNumbers() throws {
        let request = try RequestManager.makeRequest(mode: .multiple, inputText: "42, 3, 10")

        guard case .multiple(let numbers) = request else {
            return XCTFail("Expected a multiple-number request.")
        }
        XCTAssertEqual(numbers, [42, 3, 10])
    }

    func testInvalidInputs() {
        XCTAssertThrowsError(try RequestManager.makeRequest(mode: .single, inputText: " "))
        XCTAssertThrowsError(try RequestManager.makeRequest(mode: .single, inputText: "a@9"))
        XCTAssertThrowsError(try RequestManager.makeRequest(mode: .range, inputText: "10-3"))
    }
}
