import XCTest

class HomeUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShouldOpenHomeCorrectly() {
        let app = XCUIApplication()
        
        HomeAssertion.isScreenBeingPresented(app: app)
        HomeAssertion.isSearchButtonBeingPresented(app: app)
    }
}
