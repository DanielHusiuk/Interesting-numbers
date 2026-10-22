//
//  ApiService.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 22.10.2026.
//

import Foundation

enum RequestType {
    case number(Int)
    case random
    case range(start: Int, end: Int)
    case multiple([Int])
}

protocol ApiServiceProtocol {
    func fetchFacts(
        for request: RequestType,
        type: FactType,
        completion: @escaping (Result<[NumberModel], Error>) -> Void
    )
}

final class ApiService: ApiServiceProtocol {
    
    private let apiManager: ApiManagerProtocol
    
    init(apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchFacts(
        for request: RequestType,
        type: FactType,
        completion: @escaping (Result<[NumberModel], Error>) -> Void
    ) {
        var queryItems = [URLQueryItem(name: "type", value: type.rawValue)]
        let path: String
        
        switch request {
        case .number(let number):
            path = "/api/facts/\(number)"
            
        case .random:
            path = "/api/facts/random"
            
        case .range(let start, let end):
            path = "/api/facts/range"
            queryItems += [
                URLQueryItem(name: "start", value: String(start)),
                URLQueryItem(name: "end", value: String(end))
            ]
            
        case .multiple(let numbers):
            path = "/api/facts/multi"
            let joined = numbers.map { String($0) }
                .joined(separator: ",")
            queryItems.append(URLQueryItem(name: "numbers", value: joined))
        }
        
        guard let url = makeURL(path: path, queryItems: queryItems) else {
            completion(.failure(DataError.invalidData))
            return
        }
        
        switch request {
        case .number, .random:
            apiManager.fetchData(url: url) { (result: Result<NumberModel, Error>) in
                completion(result.map { [$0] })
            }
        case .range, .multiple:
            apiManager.fetchData(url: url, completion: completion)
        }
    }
    
    private func makeURL(path: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.swift.foxminded.ua"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
