//
//  RequestManager.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 23.10.2026.
//

import Foundation

enum RequestManager {
    
    static func makeRequest(
        selectedIndex: Int,
        inputText: String?
    ) throws -> RequestType {
        if selectedIndex == 1 {
            return .random
        }
        
        let text = (inputText ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else {
            throw InputError.emptyInput
        }
        let numbers = parseNumbers(from: text)
        
        switch selectedIndex {
        case 0:
            guard let numbers, numbers.count == 1 else {
                throw InputError.invalidSingle
            }
            return .number(numbers[0])
            
        case 2:
            guard let numbers,
                  numbers.count == 2,
                  numbers[0] <= numbers[1] else {
                throw InputError.invalidRange
            }
            return .range(start: numbers[0], end: numbers[1])
            
        default:
            guard let numbers, !numbers.isEmpty else {
                throw InputError.invalidList
            }
            return .multiple(numbers)
        }
    }
    
    private static func parseNumbers(from text: String) -> [Int]? {
        let parts = text
            .components(separatedBy: CharacterSet(charactersIn: ",- "))
            .filter { !$0.isEmpty }
        let numbers = parts.compactMap { Int($0) }
        return numbers.count == parts.count ? numbers : nil
    }
    
    private enum InputError: LocalizedError {
        case emptyInput
        case invalidSingle
        case invalidRange
        case invalidList
        
        var errorDescription: String? {
            switch self {
            case .emptyInput:
                return "Enter a number first."
            case .invalidSingle:
                return "Enter a single whole number, for example 42."
            case .invalidRange:
                return "Enter two numbers: start and end, for example 1-10. Start must not be greater than end."
            case .invalidList:
                return "Enter numbers separated by commas, for example 5, 10, 42."
            }
        }
    }
}
