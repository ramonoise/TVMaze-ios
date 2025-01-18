import XCTest
import SwiftUI
@testable import TVMaze

class ShowDetailCoordinatorTests: XCTestCase {
    var coordinator: ShowDetailCoordinator!
    var mockDependencies: MockTVShowDependencies!
    
    override func setUp() {
        super.setUp()
        mockDependencies = MockTVShowDependencies()
        coordinator = ShowDetailCoordinator(dependencies: mockDependencies)
    }
    
    override func tearDown() {
        coordinator = nil
        mockDependencies = nil
        super.tearDown()
    }

    @MainActor
    func testResolveEpisodeRoute() {
        let episode = MockTVShowDataSource.Stubs.tvShowDetail.episodes.first!
        let resolvedView = coordinator.resolve(route: .episode(episode))
        
        if let typedView = resolvedView as? TypedAnyView {
            XCTAssertTrue(typedView.viewType() == EpisodeView.self, "Expected EpisodeView but got \(typedView.viewType())")
        } else {
            XCTFail("Expected EpisodeView but got \(type(of: resolvedView))")
        }
    }
}
