import Foundation
import XCTest

enum ShowDetailAction {
    static func tapEpisode(app: XCUIApplication, testCase: XCTestCase?, id: Int) {
        let episode = CommonAssertion.waitForButton(app: app, testCase: testCase, identifier: "ShowDetail_Episode_\(id)")!
        XCTAssertTrue(episode.exists, "ShowDetail_Episode_\(id) should exist")
        episode.tap()
    }
}
