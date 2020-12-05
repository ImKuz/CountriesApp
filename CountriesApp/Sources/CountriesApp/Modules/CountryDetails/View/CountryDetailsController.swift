import UIKit
import Localization

final class CountryDetailsController: UIViewController {

    var interactor: CountryDetailsInteractable?
    var presenter: CountryDetailsPresenterOutput?

    private let rootView = CountryDetailsView()
    private let dataSource: CountryDetailsDiffableDataSource

    // MARK: - Init

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        dataSource = CountryDetailsTableViewDataSource.makeDataSource(rootView.tableView)
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
        dataSource.defaultRowAnimation = .automatic
        navigationItem.largeTitleDisplayMode = .never
        rootView.tableView.registerClassForCell(CountryDetailsCell.self)
        rootView.tableView.registerClassForCell(CountryDetailsHeaderCell.self)
        rootView.tableView.registerClassForCell(LoadingCell.self)
        rootView.tableView.delegate = self
    }

    private func listenToPresenter() {
        guard let presenter = presenter else { return }
        defer { interactor?.start() }

        presenter.onSnapshotUpdate = { [weak self] snapshot in
            self?.dataSource.apply(snapshot)
        }

        presenter.onTitleSetup = { [weak self] in
            self?.title = $0
        }
    }
}

// MARK: - UITableViewDelegate

extension CountryDetailsController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataSource.snapshot().sectionIdentifiers[indexPath.section] == .borders {
            interactor?.borderSelectionAction(indexPath.row - 1)
        }
    }
}

extension CountryDetailsController: CountryDetailsSnapshotProvider {

    var currentSnapshot: CountryDetailsDataSnapshot {
        dataSource.snapshot()
    }
}
