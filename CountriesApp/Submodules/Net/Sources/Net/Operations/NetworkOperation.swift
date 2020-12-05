import Foundation

final class NetworkRequestOperation: AsynchronousOperation {

    private let request: URLRequest
    private let session: URLSessionProtocol

    var task: URLSessionTaskProtocol?
    var onResult: ((Result<Data?, NetworkError>) -> Void)?

    init(request: URLRequest, session: URLSessionProtocol = URLSession.shared) {
        self.request = request
        self.session = session
        super.init()
    }

    override func main() {
        task = session.dataTask(with: request) { [weak self] data, response, error in
            defer { self?.finish() }

            if let error = error {
                self?.onResult?(.failure(NetworkError.reqeustError(error)))
            }

            guard let response = response as? HTTPURLResponse else {
                self?.onResult?(.failure(NetworkError.httpResponseError))
                return
            }

            guard case 200...299 = response.statusCode else {
                let error = Self.errorByStatusCode(response.statusCode)
                self?.onResult?(.failure(error))
                return
            }

            self?.onResult?(.success(data))
        }

        task?.resume()
    }

    override func cancel() {
        task?.cancel()
    }
}

extension NetworkRequestOperation {

    private static func errorByStatusCode(_ code: Int) -> NetworkError {
        switch code {
        case 300...399:
            return .redirected
        case 404:
            return .notFound
        case 400...499:
            return .clientError
        case 500...599:
            return .serverError
        default:
            return .unknown
        }
    }
}
