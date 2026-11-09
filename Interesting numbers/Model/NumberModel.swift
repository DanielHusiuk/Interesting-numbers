//
//  NumberModel.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 22.10.2026.
//

enum FactType: String {
    case trivia, math, year
}

struct NumberModel: Decodable {
    let number: Int
    let type: String
    let text: String
    let found: Bool?
}
