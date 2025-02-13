import XCTest
import SwiftUI
@testable import TVMaze

class HomeCoordinatorTests: XCTestCase {
    var coordinator: HomeCoordinator!
    var mockDependencies: MockTVShowDependencies!
    
    override func setUp() {
        super.setUp()
        mockDependencies = MockTVShowDependencies()
        coordinator = HomeCoordinator(dependencies: mockDependencies)
    }
    
    override func tearDown() {
        coordinator = nil
        mockDependencies = nil
        super.tearDown()
    }

    @MainActor
    func testResolveShowCardRoute() {
        let id = 1
        let resolvedView = coordinator.resolve(route: .showCard(id: id))
        
        XCTAssertTrue(resolvedView.viewType() == ShowDetailView.self, "Expected ShowDetailView but got \(resolvedView.viewType())")
    }

    @MainActor
    func testResolveSearchRoute() {
        let resolvedView = coordinator.resolve(route: .search)
        
        XCTAssertTrue(resolvedView.viewType() == SearchView.self, "Expected SearchView but got \(resolvedView.viewType())")
    }
}
