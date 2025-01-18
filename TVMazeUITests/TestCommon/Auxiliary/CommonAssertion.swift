import Foundation
import XCTest

enum CommonAssertion {
    static func waitForButton(app: XCUIApplication, testCase: XCTestCase?, identifier: String, timeout: TimeInterval = 5) -> XCUIElement? {
        let button = app.buttons[identifier]
        let existsPredicate = NSPredicate(format: "exists == true")
        
        testCase?.expectation(for: existsPredicate, evaluatedWith: button, handler: nil)
        
        testCase?.waitForExpectations(timeout: timeout) { error in
            if let error = error {
                XCTFail("Button with ID \(identifier) did not appear in time: \(error.localizedDescription)")
            } else {
                XCTAssertTrue(button.exists, "The button with ID \(identifier) exists.")
            }
        }
        
        return button
    }
}
