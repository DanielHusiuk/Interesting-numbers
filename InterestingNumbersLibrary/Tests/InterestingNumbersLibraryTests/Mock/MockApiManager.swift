import Foundation
@testable import InterestingNumbersLibrary

final class MockApiManager: ApiManagerProtocol {
    var result: Result<Any, Error> = .failure(DataError.invalidResponse)

    func fetchData<T: Decodable & Sendable>(
        url: URL,
        completion: @escaping @MainActor (Result<T, Error>) -> Void
    ) {
        let response: Result<T, Error>
        
        switch result {
        case .success(let value as T):
            response = .success(value)
        case .success:
            response = .failure(DataError.invalidData)
        case .failure(let error):
            response = .failure(error)
        }
        
        DispatchQueue.main.async {
            completion(response)
        }
    }
}
