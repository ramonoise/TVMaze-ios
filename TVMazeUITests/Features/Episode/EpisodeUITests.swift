import XCTest

private enum Constant {
    static var showId = 250
    static var episodeId = 20849
}

class EpisodeUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldOpenEpisodeCorrectly() {
        let app = XCUIApplication()
        
        HomeAssertion.isScreenBeingPresented(app: app)
        HomeAction.tapTVShow(app: app, testCase: self, id: Constant.showId)
        
        ShowDetailAction.tapEpisode(app: app, testCase: self, id: Constant.episodeId)
        EpisodeAssertion.isScreenBeingPresented(app: app)
    }
}
