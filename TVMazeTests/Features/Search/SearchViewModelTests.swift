import Combine
import Foundation
import XCTest
@testable import TVMaze


extension SearchViewModel: ViewModelWithState {
    var statePublisher: Published<SearchViewModelState>.Publisher { $state }
}

@MainActor
class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    var mockDataSource: MockTVShowDataSource!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockDataSource = MockTVShowDataSource()
        viewModel = SearchViewModel(dataSource: mockDataSource)
    }
    
    override func tearDown() {
        cancellables = []
        viewModel = nil
        mockDataSource = nil
        super.tearDown()
    }
    
    func testEmptyStateWhenSearchTextIsEmpty() {
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .emptyState) {
            self.viewModel.searchText = ""
            self.viewModel.fetchResults()
        }
    }
    
    func testLoadingState() {
        mockDataSource.shouldReturnError = false
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .loading) {
            self.viewModel.searchText = "mock"
            self.viewModel.fetchResults()
        }
    }
    
    func testNoResultsState() {
        mockDataSource.shouldReturnEmptyResults = true
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .noResults) {
            self.viewModel.searchText = "empty"
            self.viewModel.fetchResults()
        }
    }
    
    func testLoadedStateWithResults() {
        let mockShows = [TVShow(id: 1, name: "Mock Show", image: .dummy())]
        mockDataSource.mockedShows = mockShows
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .loaded(shows: mockShows)) {
            self.viewModel.searchText = "mock"
            self.viewModel.fetchResults()
        }
    }
    
    func testFailedStateWithError() {
        mockDataSource.shouldReturnError = true
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .failed(errorMessage: "Network Error")) {
            self.viewModel.searchText = "error"
            self.viewModel.fetchResults()
        }
    }
}
