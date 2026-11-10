import Foundation

public enum RequestMode {
    case single, random, range, multiple
}

public enum RequestManager {
    
    public static func makeRequest(
        mode: RequestMode,
        inputText: String?
    ) throws -> RequestType {
        
        switch mode {
        case .single:
            guard let numbers = try parseNumbers(from: inputText), numbers.count == 1 else {
                throw InputError.invalidSingle
            }
            return .number(numbers[0])
            
        case .random:
            return .random

        case .range:
            guard let numbers = try parseNumbers(from: inputText),
                  numbers.count == 2,
                  numbers[0] <= numbers[1] else {
                throw InputError.invalidRange
            }
            return .range(start: numbers[0], end: numbers[1])
            
        case .multiple:
            guard let numbers = try parseNumbers(from: inputText), !numbers.isEmpty else {
                throw InputError.invalidList
            }
            return .multiple(numbers)
        }
    }
    
    private static func parseNumbers(from inputText: String?) throws -> [Int]? {
        let text = (inputText ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else {
            throw InputError.emptyInput
        }

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
