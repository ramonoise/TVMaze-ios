import XCTest

class ShowDetailUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShouldOpenShowDetailCorrectly() {
        let app = XCUIApplication()
        
        HomeAssertion.isScreenBeingPresented(app: app)
        HomeAction.tapTVShow(app: app, testCase: self, id: 250)
        ShowDetailAssertion.isScreenBeingPresented(app: app)
    }
}
