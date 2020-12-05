public struct Language: Decodable {

    public let name: String
    public let nativeName: String

    public init(name: String, nativeName: String) {
        self.name = name
        self.nativeName = nativeName
    }
}
