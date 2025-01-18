import Foundation
import XCTest

enum SearchAssertion {
    static func isScreenBeingPresented(app: XCUIApplication) {
        let searchNavigationBarText = app.staticTexts["Search"]
        XCTAssertTrue(searchNavigationBarText.exists)
    }
}
