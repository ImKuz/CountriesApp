import Model
import Foundation

// MARK: - Interactor

protocol CountryDetailsInteractable: class {

    func start()
    func borderSelectionAction(_ index: Int)
}

// MARK: - View

protocol CountryDetailsSnapshotProvider: class {

    var currentSnapshot: CountryDetailsDataSnapshot { get }
}

// MARK: - Presenter

protocol CountryDetailsPresenterOutput: class {

    var onSnapshotUpdate: ((CountryDetailsDataSnapshot) -> Void)? { get set }
    var onTitleSetup: ((String) -> Void)? { get set }
}

protocol CountryDetailsPresenterInput {

    func configureInitialState(with model: CountryModel)
    func configureBorders(with names: [String])
}

// MARK: - Navigation

enum CountryDetailsNavigationActions {

    case details(CountryModel)
}
