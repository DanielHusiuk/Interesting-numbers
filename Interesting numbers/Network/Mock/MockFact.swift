//
//  MockFact.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 28.10.2026.
//

import Foundation
@testable import Interesting_numbers

enum MockFact {
    static let singleFact = NumberModel(
        number: 42,
        type: "trivia",
        text: "A fact for unit testing.",
        found: true
    )
}
