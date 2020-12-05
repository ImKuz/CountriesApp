import Foundation

class MockHTTPURLResponse: HTTPURLResponse {

    private let _statusCode: Int

    override var statusCode: Int {
        _statusCode
    }

    init?(code: Int) {
        _statusCode = code
        super.init(
            url: URL(string: "http://none.none")!,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
