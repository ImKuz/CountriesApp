import Foundation

struct CountriesAPIEndpoints {

    static let baseURL = URL(string: "https://restcountries.eu/rest/v2")

    struct Paths {

        static let all = "/all"
        static let search = "/name"
    }
}


