import Foundation
import Model

public class CountriesAPIService {

    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCountries(
        request: URLRequest,
        _ completion: ((CountriesListResult)-> Void)?
    ) -> URLSessionTaskProtocol? {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive

        let operation = NetworkRequestOperation(request: request, session: session)

        operation.onResult = { result in
            switch result {
            case .success(let data):
                let decodingResult = Self.mapData(data)
                completion?(decodingResult)
            case .failure(let error):
                completion?(.failure(APIError.networkError(error)))
            }
        }

        queue.addOperation(operation)
        return operation.task
    }

    private static func mapData(_ data: Data?) -> CountriesListResult {
        guard let data = data else {
            return.failure(APIError.unexpected)
        }
        do {
            let models = try JSONDecoder().decode([CountryModel].self, from: data)
            return .success(models)
        } catch let error {
            return .failure(APIError.decodingError(error))
        }
    }
}

// MARK: - Protocol conformance

extension CountriesAPIService: CountriesAPI {

    public func countriesList(_ completion: ((CountriesListResult) -> Void)?) -> URLSessionTaskProtocol? {
        guard let request = CountriesAPIRequestFactory.makeAllCountriesRequest() else {
            completion?(.failure(.badRequest))
            return nil
        }

        return fetchCountries(request: request, completion)
    }

    public func countriesList(
        searchText: String,
        _ completion: ((CountriesListResult) -> Void)?
    ) -> URLSessionTaskProtocol? {
        guard !searchText.isEmpty else {
            return countriesList(completion)
        }

        guard let request = CountriesAPIRequestFactory.makeSearchRequest(text: searchText) else {
            completion?(.failure(.badRequest))
            return nil
        }

        return fetchCountries(request: request, completion)
    }

    public func countriesList(
        by codes: [String],
        _ completion: ((CountriesListResult) -> Void)?
    ) -> URLSessionTaskProtocol? {
        let task = countriesList { result in
            switch result {
            case .success(let models):
                let filtredModels = models.filter { codes.contains($0.code) }
                completion?(.success(filtredModels))
            case .failure(let error):
                completion?(.failure(error))
            }
        }

        return task
    }
}
