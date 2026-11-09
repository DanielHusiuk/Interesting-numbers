//
//  MockApiManager.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 28.10.2026.
//

import Foundation
@testable import Interesting_numbers

final class MockApiManager: ApiManagerProtocol {
    var result: Result<Any, Error> = .failure(DataError.invalidResponse)

    func fetchData<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        switch result {
        case .success(let value as T):
            completion(.success(value))
        case .success:
            completion(.failure(DataError.invalidData))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
