import Foundation
import Model
import Net

final class CountryDetailsInteractor: CountryDetailsInteractable {

    // MARK: - Properties

    var onNavigation: ((CountryDetailsNavigationActions) -> Void)?

    private let presenter: CountryDetailsPresenterInput
    private let countriesService: CountriesAPI
    private var model: CountryModel
    private var fetchTasks = [URLSessionTaskProtocol?]()
    private var fetchedBorders = [CountryModel]()

    // MARK: - Init

    init(
        model: CountryModel,
        presenterInput: CountryDetailsPresenterInput,
        countriesService: CountriesAPI
    ) {
        self.model = model
        self.presenter = presenterInput
        self.countriesService = countriesService
    }

    deinit {
        fetchTasks.forEach { $0?.cancel() }
    }

    // MARK: - Configuration

    func start() {
        presentInitialState()
        setPresenterLoading(true)

        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchBorders()
        }
    }

    private func fetchBorders() {
        let task = countriesService.countriesList(by: model.borders) { [weak self] result in
            self?.setPresenterLoading(false)
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let models):
                self?.fetchedBorders = models
                self?.presentBorders()
            }
        }

        fetchTasks.append(task)
    }
}

// MARK: - Controller actions

extension CountryDetailsInteractor {

    func borderSelectionAction(_ index: Int) {
        let model = fetchedBorders[index]
        onNavigation?(.details(model))
    }
}

// MARK: - Presenter manipulation

private extension CountryDetailsInteractor {

    func setPresenterLoading(_ isLoading: Bool) {
        DispatchQueue.main.async { [self] in
            presenter.setLoadingBorders(isLoading)
        }
    }

    func presentInitialState() {
        DispatchQueue.main.async { [self] in
            presenter.configureInitialState(with: model)
        }
    }

    func presentBorders() {
        DispatchQueue.main.async { [self] in
            presenter.configureBorders(with: fetchedBorders.map(\.name))
        }
    }
}
