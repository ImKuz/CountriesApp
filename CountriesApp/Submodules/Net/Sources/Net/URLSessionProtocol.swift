import Foundation

public typealias DataTaskOutput = (Data?, URLResponse?, Error?)
public typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

public protocol URLSessionProtocol {

    func dataTask(
        with urlRequest: URLRequest,
        completion: @escaping DataTaskCompletion
    ) -> URLSessionTaskProtocol
}

extension URLSession: URLSessionProtocol {

    public func dataTask(
        with urlRequest: URLRequest,
        completion: @escaping DataTaskCompletion
    ) -> URLSessionTaskProtocol {
        dataTask(with: urlRequest, completionHandler: completion)
    }
}
