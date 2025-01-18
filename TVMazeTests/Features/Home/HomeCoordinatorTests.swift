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
        
        if let typedView = resolvedView as? TypedAnyView {
            XCTAssertTrue(typedView.viewType() == ShowDetailView.self, "Expected ShowDetailView but got \(typedView.viewType())")
        } else {
            XCTFail("Expected ShowDetailView but got \(type(of: resolvedView))")
        }
    }

    @MainActor
    func testResolveSearchRoute() {
        let resolvedView = coordinator.resolve(route: .search)
        
        if let typedView = resolvedView as? TypedAnyView {
            XCTAssertTrue(typedView.viewType() == SearchView.self, "Expected SearchView but got \(typedView.viewType())")
        } else {
            XCTFail("Expected SearchView but got \(type(of: resolvedView))")
        }
    }
}
