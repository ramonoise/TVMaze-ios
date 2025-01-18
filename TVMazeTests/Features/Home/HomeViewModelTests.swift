import Combine
import XCTest
@testable import TVMaze

extension HomeViewModel: ViewModelWithState {
    var statePublisher: Published<HomeViewModelState>.Publisher { $state }
}

@MainActor
class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockDataSource: MockTVShowDataSource!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockDataSource = MockTVShowDataSource()
        viewModel = HomeViewModel(dataSource: mockDataSource)
    }

    override func tearDown() {
        cancellables = []
        viewModel = nil
        mockDataSource = nil
        super.tearDown()
    }

    func testLoadingState() {
        mockDataSource.shouldReturnError = false
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .loading) {
            Task {
                await self.viewModel.loadData()
            }
        }
    }

    func testLoadedStateWithSections() {
        let mockShows = [TVShow(id: 1, name: "Mock Show", image: .dummy())]
        let expectedSection = HomeSectionItem(title: "All Shows", items: mockShows, type: .expanded(page: 1))
        mockDataSource.mockedShows = mockShows
        
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .loaded(sections: [expectedSection])) {
            Task {
                await self.viewModel.loadData()
            }
        }
    }

    func testFailedStateWithError() {
        mockDataSource.shouldReturnError = true
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .failed(errorMessage: "Network Error")) {
            Task {
                await self.viewModel.loadData()
            }
        }
    }
}
