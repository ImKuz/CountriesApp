import Foundation
import Model

public enum APIError: Error {

    case networkError(NetworkError)
    case decodingError(Error)
    case badRequest
    case unexpected
}

public protocol CountriesAPI {

    typealias CountriesListResult = Result<[CountryModel], APIError>

    func countriesList(_ completion: ((CountriesListResult) -> Void)?) -> URLSessionTaskProtocol?

    func countriesList(
        searchText: String,
        _ completion: ((CountriesListResult) -> Void)?
    ) -> URLSessionTaskProtocol?

    func countriesList(
        by codes: [String],
        _ completion: ((CountriesListResult) -> Void)?
    ) -> URLSessionTaskProtocol?
}
