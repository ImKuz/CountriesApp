import Foundation

public struct CountryModel: Decodable {

    public let name: String
    public let code: String
    public let nativeName: String
    public let flag: URL
    public let currencies: [Currency]
    public let languages: [Language]
    public let borders: [String]

    public init(
        name: String,
        code: String,
        nativeName: String,
        flag: URL,
        currencies: [Currency],
        languages: [Language],
        borders: [String]
    ) {
        self.name = name
        self.code = code
        self.nativeName = nativeName
        self.flag = flag
        self.currencies = currencies
        self.languages = languages
        self.borders = borders
    }
}

public extension CountryModel {

    enum CodingKeys: String, CodingKey {
        case name
        case nativeName
        case flag
        case currencies
        case languages
        case borders
        case code = "alpha3Code"
    }
}
