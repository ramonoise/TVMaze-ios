import Foundation
import XCTest

enum HomeAction {
    static func tapSearchButton(app: XCUIApplication, testCase: XCTestCase) {
        let searchButton = CommonAssertion.waitForButton(app: app, testCase: testCase, identifier: "SearchButton")!
        XCTAssertTrue(searchButton.exists, "Search button should exist")
        searchButton.tap()
    }
    
    static func tapTVShow(app: XCUIApplication,  testCase: XCTestCase, id: Int) {
        let tvShowItem = CommonAssertion.waitForButton(app: app, testCase: testCase, identifier: "TVShow_\(id)")!
        XCTAssertTrue(tvShowItem.exists, "TV Show \(id) should exist")
        tvShowItem.tap()
    }
}
