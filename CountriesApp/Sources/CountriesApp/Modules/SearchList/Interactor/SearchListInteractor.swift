import Foundation
import Model
import Net

final class SearchListInteractor: SearchListInteractable {

    // MARK: - Propertis

    var onNavigation: ((SearchListNavigationActions) -> Void)?

    let presenter: SearchListPresentable
    private let countriesService: CountriesAPI

    private var fetchTask: URLSessionTaskProtocol?
    private var fetchedData = [CountryModel]()

    // MARK: - Init

    init(presenter: SearchListPresentable, countriesService: CountriesAPI) {
        self.presenter = presenter
        self.countriesService = countriesService
    }

    deinit {
        fetchTask?.cancel()
    }

    // MARK: - Setup

    func start() {
        searchAction("")
    }
}

// MARK: - Actions

extension SearchListInteractor {

    func searchAction(_ text: String) {
        fetchTask?.cancel()
        setPresenter(isLoading: true)
        fetchTask = countriesService.countriesList(searchText: text) { [weak self] result in
            self?.setPresenter(isLoading: false)

            switch result {
            case .failure(let error):
                self?.setPresenter(display: error)
            case .success(let models):
                self?.fetchedData = models
                let presenterModel = SearchListPresenterModel(countries: models)
                DispatchQueue.main.async {
                    self?.presenter.configure(with: presenterModel)
                }
            }
        }
    }

    func selectionAction(_ indexPath: IndexPath) {
        let model = fetchedData[indexPath.row]
        onNavigation?(.details(model))
    }
}

// MARK: - Presenter Manipulation

private extension SearchListInteractor {

    func setPresenter(isLoading: Bool) {
        DispatchQueue.main.async {
            self.presenter.onViewStateChange?(.loading(isLoading))
        }
    }

    func setPresenter(display error: APIError) {
        DispatchQueue.main.async {
            switch error {
            case .networkError(.notFound):
                let emptyPresenterModel = SearchListPresenterModel(countries: [])
                self.presenter.configure(with: emptyPresenterModel)
            default:
                self.presenter.onViewStateChange?(.error("Something went wrong"))
            }
        }
    }
}
