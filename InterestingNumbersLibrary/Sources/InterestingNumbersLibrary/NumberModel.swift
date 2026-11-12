public enum FactType: String {
    case trivia, math, year
}

public struct NumberModel: Decodable & Sendable {
    public let number: Int
    let type: String
    public let text: String
    let found: Bool?

    public init(number: Int, type: String, text: String, found: Bool?) {
        self.number = number
        self.type = type
        self.text = text
        self.found = found
    }
}
