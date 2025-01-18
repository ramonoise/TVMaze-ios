import Foundation
@testable import TVMaze

final class MockTVShowDependencies: TVShowDependencies {
    var tvShowDataSource: TVShowDataSourceProtocol
    var mockTVShowDataSource: MockTVShowDataSource!
    
    init(tvShowDataSource: TVShowDataSourceProtocol) {
        self.tvShowDataSource = tvShowDataSource
    }
    
    init() {
        let mockDataSource = MockTVShowDataSource()

        self.tvShowDataSource = mockDataSource
        self.mockTVShowDataSource = mockDataSource
    }
}
