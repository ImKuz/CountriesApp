public struct Currency: Decodable {

    public let code: String?
    public let name: String?
    public let symbol: String?

    public init(
        code: String?,
        name: String?,
        symbol: String?
    ) {
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}
