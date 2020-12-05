import Net
import Model
import Foundation

extension CountryModel {

    static func mock(_ index: Int) -> Self {
        let currencies = [
            Currency(
                code: "CurrencyCode0-\(index)",
                name: "CurrencyName0-\(index)",
                symbol: "CurrencySymbol0-\(index)"
            ),
            Currency(
                code: "CurrencyCode1-\(index)",
                name: "CurrencyName1-\(index)",
                symbol: "CurrencySymbol1-\(index)"
            )
        ]

        let languages = [
            Language(name: "LanguageName1-\(index)", nativeName: "LanguageNativeName1-\(index)"),
            Language(name: "LanguageName2-\(index)", nativeName: "LanguageNativeName2-\(index)")
        ]

        return CountryModel(
            name: "CountryName-\(index)",
            code: "CountryCode-\(index)",
            nativeName: "CountryNativeName-\(index)",
            flag: URL(string: "http://test.com")!,
            currencies: currencies,
            languages: languages,
            borders: ["BORD1", "BORD2", "BORD3"]
        )
    }
}

class CountriesServiceFake {

    let stub = [CountryModel.mock(0), CountryModel.mock(1)]

    var onNextRequestError: APIError?
    var onNextRequestResult: CountriesListResult?

    var inputSearchString: String?
    var inputSearchCodes: [String]?

    var responseDelay: TimeInterval?

    func shouldThrow(error: APIError) {
        onNextRequestError = error
    }

    func shouldSet(result: CountriesListResult) {
        onNextRequestResult = result
    }

    var listCallBack: (() -> Void)?
    var bordersCallback: (() -> Void)?

    func tearDown() {
        inputSearchString = nil
        inputSearchCodes = nil
        onNextRequestError = nil
        onNextRequestResult = nil
        responseDelay = nil
    }

    private var preparedResult: CountriesListResult {
        if let error = onNextRequestError {
            return .failure(error)
        } else if let result = onNextRequestResult {
            return result
        } else {
            return .success(stub)
        }
    }

    private func execute(_ block: @escaping () -> Void) {
        let timeInterval = responseDelay ?? TimeInterval(0)
        DispatchQueue
            .global(qos: .userInitiated)
            .asyncAfter(deadline: .now() + timeInterval) {
            block()
        }
    }
}

extension CountriesServiceFake: CountriesAPI {

    func countriesList(_ completion: ((CountriesListResult) -> Void)?) -> URLSessionTaskProtocol? {
        execute {
            completion?(self.preparedResult)
            self.listCallBack?()
        }

        return nil
    }

    func countriesList(
        searchText: String,
        _ completion: ((CountriesListResult) -> Void)?
    ) -> URLSessionTaskProtocol? {
        inputSearchString = searchText
        execute {
            completion?(self.preparedResult)
            self.listCallBack?()
        }

        return nil
    }

    func countriesList(
        by codes: [String],
        _ completion: ((CountriesListResult) -> Void)?
    ) -> URLSessionTaskProtocol? {
        inputSearchCodes = codes
        execute {
            completion?(self.preparedResult)
            self.bordersCallback?()
        }

        return nil
    }
}
