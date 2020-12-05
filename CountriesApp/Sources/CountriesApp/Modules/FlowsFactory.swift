import Model
import UIKit
import Net

// MARK: - DetailsModule

enum FlowsFactory {

    struct CountryDetailsModuleInput {

        let model: CountryModel
        let countriesService: CountriesAPI
        let onNavigation: ((CountryDetailsNavigationActions) -> Void)?
    }

    static func makeCountryDetailsModule(with input: CountryDetailsModuleInput) -> UIViewController {
        let controller = CountryDetailsController()
        let presenter = CountryDetailsPresenter()
        presenter.snapshotProvider = controller
        let interactor = CountryDetailsInteractor(
            model: input.model,
            presenterInput: presenter,
            countriesService: input.countriesService
        )

        controller.interactor = interactor
        controller.presenter = presenter
        interactor.onNavigation = input.onNavigation

        return controller
    }
}

// MARK: - SearchList

extension FlowsFactory {

    struct SearchListModuleInput {

        let countriesService: CountriesAPI
        let onNavigation: ((SearchListNavigationActions) -> Void)?
    }

    static func makeSearchListModule(with input: SearchListModuleInput) -> UIViewController {
        let controller = SearchListController()
        let presenter = SearchListPresenter()
        let interactor = SearchListInteractor(
            presenter: presenter,
            countriesService: input.countriesService
        )

        interactor.onNavigation = input.onNavigation
        controller.interactor = interactor

        return controller
    }
}

// MARK: - EmptyModule

extension FlowsFactory {

    static func makeEmptyModule() -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .systemGray6
        controller.view = PlaceholderView()
        return controller
    }
}
