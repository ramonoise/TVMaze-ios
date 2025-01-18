import XCTest

class SearchUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShouldOpenSearchCorrectly() {
        let app = XCUIApplication()
        
        HomeAssertion.isScreenBeingPresented(app: app)
        HomeAction.tapSearchButton(app: app, testCase: self)
        SearchAssertion.isScreenBeingPresented(app: app)
    }
}
