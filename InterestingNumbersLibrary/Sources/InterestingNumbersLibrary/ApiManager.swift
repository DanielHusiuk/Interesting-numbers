import Foundation

enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

protocol ApiManagerProtocol: AnyObject {
    func fetchData<T: Decodable & Sendable>(
        url: URL,
        completion: @escaping @MainActor (Result<T, Error>) -> Void
    )
}

final class ApiManager: ApiManagerProtocol {
    
    func fetchData<T: Decodable & Sendable>(
        url: URL,
        completion: @escaping @MainActor (Result<T, Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(DataError.message(error)))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(DataError.invalidData))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                DispatchQueue.main.async {
                    completion(.failure(DataError.invalidResponse))
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(DataError.message(error)))
                }
            }
        }.resume()
    }
}

// MARK: - Extensions

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "The server returned no data"
        case .invalidResponse:
            return "The server rejected the request. Check entered numbers"
        case .message(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }
}
