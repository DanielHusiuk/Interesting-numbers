//
//  MockService.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 09.11.2026.
//

import Foundation

final class MockService: ApiServiceProtocol {
    
    func fetchFacts(
        for request: RequestType,
        type: FactType,
        completion: @escaping (Result<[NumberModel], Error>) -> Void
    ) {
        let numbers: [Int]
        
        switch request {
        case .number(let value):
            numbers = [value]
        case .random:
            numbers = [42]
        case .range(let start, let end):
            numbers = Array(start...end)
        case .multiple(let values):
            numbers = values
        }
        
        let facts = numbers.map { number in
            NumberModel(
                number: number,
                type: type.rawValue,
                text: "A fact for UI testing.",
                found: true
            )
        }
        DispatchQueue.main.async {
            completion(.success(facts))
        }
    }
}
