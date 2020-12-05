import XCTest
import Model
@testable import CountriesApp

class CountryDetailsInteractionTests: XCTestCase {
    let service = CountriesServiceFake()
    var presenter = CountryDetailsPresenterSpy()
    var interactor: CountryDetailsInteractor?

    override func setUp() {
        interactor = CountryDetailsInteractor(
            model: .mock(0),
            presenterInput: presenter,
            countriesService: service
        )
    }

    override func tearDown() {
        service.tearDown()
        presenter = CountryDetailsPresenterSpy()
    }

    func testBordersFetch() {
        let fetchingBordersExpectation = expectation(description: "fetchingBordersExpectation")
        var fetchedBorders: [String]?
        interactor?.start()

        presenter.configuredBorders = { names in
            fetchedBorders = names
            fetchingBordersExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: { _ in
             XCTAssertNotNil(fetchedBorders)
        })
    }

    func testInitialLoading() {
        let setupExpectation = expectation(description: "setupExpectation")
        var isLoaded = false
        interactor?.start()

        presenter.comfiguredInitialState = { _ in
            isLoaded = true
            setupExpectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: { _ in
            XCTAssert(isLoaded)
        })
    }

    func testSelectionIsProcessed() {
        let fetchingBordersExpectation = expectation(description: "fetchingBordersExpectation")
        let navigationExpectation = expectation(description: "navigationExpectation")

        interactor?.start()

        presenter.configuredBorders = { [weak self] _ in
            fetchingBordersExpectation.fulfill()
            self?.interactor?.borderSelectionAction(0)
        }

        interactor?.onNavigation = { route in
            if case .details = route {
                navigationExpectation.fulfill()
            }
        }

        wait(
            for: [fetchingBordersExpectation, navigationExpectation],
            timeout: 1,
            enforceOrder: true
        )
    }
}
