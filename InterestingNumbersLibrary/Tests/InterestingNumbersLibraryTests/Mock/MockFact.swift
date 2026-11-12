import Foundation
@testable import InterestingNumbersLibrary

enum MockFact {
    static let singleFact = NumberModel(
        number: 42,
        type: "trivia",
        text: "A fact for unit testing.",
        found: true
    )
}
