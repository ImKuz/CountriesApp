import Model
@testable import CountriesApp

class CountryDetailsPresenterSpy: CountryDetailsPresenterInput {

    var configuredBorders: (([String]) -> Void)?
    var comfiguredInitialState: ((CountryModel?) -> Void)?
    var wasSetToLoading: (() -> Void)?

    func configureBorders(with names: [String]) {
        configuredBorders?(names)
    }

    func configureInitialState(with model: CountryModel) {
        comfiguredInitialState?(model)
    }

    func setLoadingBorders(_ isLoading: Bool) {
        if isLoading {
            wasSetToLoading?()
        }
    }
}
