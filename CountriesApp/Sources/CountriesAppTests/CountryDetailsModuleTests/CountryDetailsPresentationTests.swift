import XCTest
import Model
@testable import CountriesApp

class CountryDetailsSnapshotProviderFake: CountryDetailsSnapshotProvider {

    let tableView = UITableView()
    let dataSource: CountryDetailsDiffableDataSource

    var currentSnapshot: CountryDetailsDataSnapshot {
        dataSource.snapshot()
    }

    init() {
        dataSource = CountryDetailsTableViewDataSource.makeDataSource(tableView)
        registerCells()
    }

    func apply(_ snapshot: CountryDetailsDataSnapshot) {
        dataSource.apply(snapshot)
    }

    private func registerCells() {
        tableView.registerClassForCell(CountryDetailsCell.self)
        tableView.registerClassForCell(CountryDetailsHeaderCell.self)
        tableView.registerClassForCell(LoadingCell.self)
        tableView.registerClassForCell(СountryDetailsSectionHeaderCell.self)
    }
}

class CountryDetailsPresentationTests: XCTestCase {
    let service = CountriesServiceFake()
    var presenter = CountryDetailsPresenter()
    var snapshotProvider = CountryDetailsSnapshotProviderFake()
    var interactor: CountryDetailsInteractor?
    var controller: CountryDetailsController!

    override func setUp() {
        snapshotProvider = CountryDetailsSnapshotProviderFake()
        interactor = CountryDetailsInteractor(
            model: .mock(0),
            presenterInput: presenter,
            countriesService: service
        )

        presenter.snapshotProvider = snapshotProvider
    }

    override func tearDown() {
        service.tearDown()
    }

    func testLoading() {
        let loadingExpectation = expectation(description: "loadingExpectation")
        loadingExpectation.assertForOverFulfill = false
        interactor?.start()

        presenter.onSnapshotUpdate = { [weak self] state in

            if !state.itemIdentifiers(inSection: .borders).contains(.loader) {
                loadingExpectation.fulfill()
            }

            self?.snapshotProvider.apply(state)
        }

        wait(for: [loadingExpectation], timeout: 1.0)
    }

    func testCommonDataIsPresented() {
        let currenciesExpectation = expectation(description: "currenciesExpectation")
        let languagesExpectation = expectation(description: "languagesExpectation")
        let headerExpectation = expectation(description: "headerExpectation")

        currenciesExpectation.assertForOverFulfill = false
        languagesExpectation.assertForOverFulfill = false
        headerExpectation.assertForOverFulfill = false

        interactor?.start()

        presenter.onSnapshotUpdate = { [weak self] state in

            if !state.itemIdentifiers(inSection: .currencies).isEmpty {
                currenciesExpectation.fulfill()
            }

            if !state.itemIdentifiers(inSection: .languages).isEmpty {
                languagesExpectation.fulfill()
            }

            if !state.itemIdentifiers(inSection: .header).isEmpty {
                headerExpectation.fulfill()
            }

            self?.snapshotProvider.apply(state)
        }

        wait(
            for: [
                currenciesExpectation,
                languagesExpectation,
                headerExpectation
            ],
            timeout: 1.0
        )
    }

    func testBorderDataIsPresented() {
        let bordersExpectation = expectation(description: "bordersExpectation")
        interactor?.start()

        presenter.onSnapshotUpdate = { [weak self] state in

            if state.itemIdentifiers(inSection: .borders).count > 1 {
                bordersExpectation.fulfill()
            }

            self?.snapshotProvider.apply(state)
        }

        wait(for: [bordersExpectation], timeout: 1.0)
    }

}
