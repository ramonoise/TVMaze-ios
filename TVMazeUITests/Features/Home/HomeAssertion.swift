import Foundation
import XCTest

enum HomeAssertion {
    static func isScreenBeingPresented(app: XCUIApplication) {
        let homeTitle = app.staticTexts["Home"]
        XCTAssertTrue(homeTitle.exists, "Home screen is being presented")
    }
    
    static func isSearchButtonBeingPresented(app: XCUIApplication) {
        let searchButton = app.buttons["SearchButton"]
        XCTAssertTrue(searchButton.exists, "Search button should exist")
    }
}
