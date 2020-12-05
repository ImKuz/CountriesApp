import Foundation

enum CountriesAPIRequestFactory {

    static func makeAllCountriesRequest() -> URLRequest? {
        guard var url = CountriesAPIEndpoints.baseURL else { return nil }
        url.appendPathComponent(CountriesAPIEndpoints.Paths.all)

        return URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
    }

    static func makeSearchRequest(text: String) -> URLRequest? {
        guard var url = CountriesAPIEndpoints.baseURL else { return nil }
        url.appendPathComponent(CountriesAPIEndpoints.Paths.search + "/\(text)")

        return URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
    }
}
