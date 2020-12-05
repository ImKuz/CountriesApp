import Model
import Foundation

protocol SearchListInteractable {

    var presenter: SearchListPresentable { get }

    func start()
    func searchAction(_ text: String)
    func selectionAction(_ indexPath: IndexPath)
}

protocol SearchListPresentable: class {

    var onViewStateChange: ((SearchListViewState) -> Void)? { get set }

    func configure(with: SearchListPresenterModel)
}

enum SearchListNavigationActions {

    case details(CountryModel)
}
