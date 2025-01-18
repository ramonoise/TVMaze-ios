import Foundation
import XCTest

enum EpisodeAssertion {
    static func isScreenBeingPresented(app: XCUIApplication) {
        let nameTitle = app.staticTexts["Episode_Title_Name"]
        XCTAssertTrue(nameTitle.exists)
        
        let seasonEpisodeNumbers = app.staticTexts["Episode_SeasonEpisodeNumbers"]
        XCTAssertTrue(seasonEpisodeNumbers.exists)
        
        let summary = app.scrollViews["Episode_Scroll_Summary"]
        XCTAssertTrue(summary.exists)
    }
}
