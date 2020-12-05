import UIKit
import Localization

final class SearchListController: UIViewController {

    // MARK: - Properties

    var interactor: SearchListInteractable?

    private let rootView = SearchListView()
    private let dataSource: SearchListDiffableDataSource

    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = TextConstants.searchBarPlaceholder
        controller.searchBar.accessibilityTraits = UIAccessibilityTraits.searchField

        return controller
    }()

    // MARK: - Init

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        dataSource = SearchListTableViewDataSource.makeDataSource(rootView.tableView)
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listenToPresenter()
    }

    // MARK: - Setup

    private func setup() {
        searchController.searchResultsUpdater = self
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController

        rootView.tableView.registerClassForCell(SearchListCell.self)
        rootView.tableView.delegate = self

        title = TextConstants.title
    }

    private func listenToPresenter() {
        guard let presenter = interactor?.presenter else { return }
        defer { interactor?.start() }

        presenter.onViewStateChange = { [weak self] state in
            switch state {
            case .data(let viewModel):
                self?.dataSource.apply(viewModel.dataSnapshot)
            case .error(let errorMessage):
                print(errorMessage)
            case .loading(let isLoading):
                if isLoading {
                    self?.showLoading()
                } else {
                    self?.restoreLoading()
                }
            }
        }
    }

    private func restoreLoading() {
        self.navigationItem.rightBarButtonItem = nil
    }

    private func showLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        activityIndicator.startAnimating()
    }
}

// MARK: - UITableViewDelegate

extension SearchListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.selectionAction(indexPath)
    }
}

extension SearchListController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            interactor?.searchAction(text)
        }
    }
}

// MARK: - Constants

private extension SearchListController {

    enum TextConstants {

        static let title = "search_list_title".localized()
        static let searchBarPlaceholder = "search_list_search_bar_placeholder".localized()
    }
}
