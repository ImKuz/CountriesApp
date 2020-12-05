import Foundation

public protocol URLSessionTaskProtocol: class {

    func resume()
    func cancel()
}

extension URLSessionTask: URLSessionTaskProtocol {}
