import XCTest
@testable import Net

final class NetworkOperationTests: XCTestCase {

    static let mockURL = URL(string: "http://ya.ru")!
    static let mockRequest = URLRequest(url: mockURL)

    func testDataPassed() {
        let queue = OperationQueue()
        var result: Result<Data?, NetworkError>?

        let operation = NetworkRequestOperation(
            request: Self.mockRequest,
            session: Self.makeURLSession(with: Response.success)
        )

        operation.onResult = {
            result = $0
        }

        queue.addOperation(operation)
        queue.waitUntilAllOperationsAreFinished()

        switch result {
        case .none:
            XCTFail("no result")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        case .success(let data):
            if data == nil {
                XCTFail("data is nil")
            }
        }
    }

    func testErrorHandling() {
        let queue = OperationQueue()
        var result: Result<Data?, NetworkError>?
        let session = Self.makeURLSession(with: Response.failureServer)

        let operation = NetworkRequestOperation(
            request: Self.mockRequest,
            session: session
        )

        operation.onResult = {
            result = $0
        }

        queue.addOperation(operation)
        queue.waitUntilAllOperationsAreFinished()

        switch result {
        case .none:
            XCTFail("no result")
        case .failure(let error):
            guard case .serverError = error else {
                XCTFail("wrong error")
                return
            }
        case .success:
            XCTFail("unexpected success")
        }
    }

    static var allTests = [
        ("testDataPassed", testDataPassed),
    ]
}

extension NetworkOperationTests {

    static func makeURLSession(with response: HTTPURLResponse) -> URLSessionProtocol {
        MockURLSession(
            output: (
                Data(),
                response,
                nil
            )
        )
    }

    enum Response {

        static let success = HTTPURLResponse(
            url: NetworkOperationTests.mockURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        static let failureServer = HTTPURLResponse(
            url: NetworkOperationTests.mockURL,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )!

        static let failureClient = HTTPURLResponse(
            url: NetworkOperationTests.mockURL,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!

        static let failureNotFound = HTTPURLResponse(
            url: NetworkOperationTests.mockURL,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!

        static let unknown = HTTPURLResponse(
            url: NetworkOperationTests.mockURL,
            statusCode: 999,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
