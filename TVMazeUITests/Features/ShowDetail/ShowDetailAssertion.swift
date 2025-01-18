import Foundation
import XCTest

enum ShowDetailAssertion {
    static func isScreenBeingPresented(app: XCUIApplication) {
        let title = app.staticTexts["ShowDetail_Title"]
        XCTAssertTrue(title.exists, "ShowDetail's Title is being presented")
        
        let genres = app.staticTexts["ShowDetail_Genres"]
        XCTAssertTrue(genres.exists, "ShowDetail's Genres are being presented")
        
        let airDate = app.staticTexts["ShowDetail_AirDate"]
        XCTAssertTrue(airDate.exists, "ShowDetail's AirDate is being presented")
        
        let summary = app.scrollViews["ShowDetail_Summary"]
        XCTAssertTrue(summary.exists, "ShowDetail's Summary is being presented")

        let episodes = app.scrollViews["ShowDetail_Episodes"]
        XCTAssertTrue(episodes.exists, "ShowDetail's Episodes are being presented")
    }
}
