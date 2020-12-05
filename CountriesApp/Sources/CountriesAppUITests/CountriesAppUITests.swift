import XCTest

extension XCUIApplication {

    var searchBar: XCUIElement { searchFields.firstMatch }
    //var submitButton: XCUIElement { self.buttons["submit-button"] }
}

class CountriesAppUITests: XCTestCase {

    func testExample() throws {
        let app = XCUIApplication()

        app.launch()

        // Given the user has typed "SWE" in searchBar
        app.searchBar.tap()
        app.searchBar.typeText("SWE")

        // When a cell with "Sweden" title has appeared in the list
        let nameTitle = app.staticTexts["Sweden"]
        XCTAssert(nameTitle.exists)

        // And the user has tapped on it
        nameTitle.tap()

        // Then label with "Sverige has appeared"
        let nativeName = app.staticTexts["Sverige"]
        XCTAssert(nativeName.exists)

    }
}
