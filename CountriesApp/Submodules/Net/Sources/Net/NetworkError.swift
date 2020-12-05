public enum NetworkError: Error {

    case reqeustError(Error)
    case httpResponseError
    case redirected
    case clientError
    case serverError
    case notFound
    case badRequest
    case unknown
}
