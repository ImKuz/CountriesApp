import XCTest
import Model
@testable import CountriesApp

class SearchListInteractorTests: XCTestCase {
    let service = CountriesServiceFake()
    let presenter = SearchListPresenter()
    var interactor: SearchListInteractor?

    override func setUp() {
        interactor = SearchListInteractor(
            presenter: presenter,
            countriesService: service
        )
    }

    override func tearDown() {
        service.tearDown()
    }

    func testInititalLoading() {
        let expectation = XCTestExpectation()

        service.responseDelay = 0.1

        presenter.onViewStateChange = {
            if case .loading(let isLoading) = $0 {
                XCTAssert(isLoading)
                expectation.fulfill()
            }
        }

        interactor?.start()
        wait(for: [expectation], timeout: 1)
    }

    func testSearchAction() {
        let searchString = "ABC"
        interactor?.start()
        interactor?.searchAction(searchString)

        XCTAssert(service.inputSearchString == searchString)
    }

    func testSelection() {
        let expectation = XCTestExpectation()

        interactor?.onNavigation = { [weak self] route in

            if case .details(let model) = route {
                XCTAssert(model.code == self?.service.stub[0].code)
                expectation.fulfill()
            }
        }

        presenter.onViewStateChange = { [weak self] state in
            switch state {
            case .data:
                self?.interactor?.selectionAction(IndexPath(item: 0, section: 0))
            case .error(let message):
                XCTFail(message)
            case .loading:
                return
            }
        }

        interactor?.start()
        wait(for: [expectation], timeout: 1)
    }

    func testErrorHandling() {
        let expectation = XCTestExpectation()

        service.onNextRequestError = .badRequest

        presenter.onViewStateChange = { state in
            if case .error(let message) = state {
                XCTAssertFalse(message.isEmpty)
                expectation.fulfill()
            }
        }

        interactor?.start()
        wait(for: [expectation], timeout: 1)
    }

    func testNotFoundHandling() {
        let expectation = XCTestExpectation()

        service.onNextRequestError = .networkError(.notFound)

        presenter.onViewStateChange = { state in
            if case .data = state {
                expectation.fulfill()
            }
        }

        interactor?.start()
        wait(for: [expectation], timeout: 1)
    }
}
