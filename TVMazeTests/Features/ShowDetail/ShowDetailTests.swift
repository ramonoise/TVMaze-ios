import Combine
import XCTest
@testable import TVMaze

extension ShowDetailViewModel: ViewModelWithState {
    var statePublisher: Published<ShowDetailViewModelState>.Publisher { $state }
}

@MainActor
class ShowDetailViewModelTests: XCTestCase {
    var viewModel: ShowDetailViewModel!
    var mockDataSource: MockTVShowDataSource!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockDataSource = MockTVShowDataSource()
        viewModel = ShowDetailViewModel(showId: 1, dataSource: mockDataSource)
    }

    override func tearDown() {
        cancellables = []
        viewModel = nil
        mockDataSource = nil
        super.tearDown()
    }

    func testLoadingState() {
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .loading) {
            Task {
                await self.viewModel.loadData()
            }
        }
    }

    func testLoadedStateWithShowDetail() {
        let mockShowDetail = MockTVShowDataSource.Stubs.tvShowDetail
        mockDataSource.mockedShowDetail = mockShowDetail
        
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .loaded(showDetail: mockShowDetail)) {
            Task {
                await self.viewModel.loadData()
            }
        }
    }

    func testFailedStateWithError() {
        mockDataSource.shouldReturnErrorForShowDetail = true
        self.observeState(viewModel: self.viewModel,
                          cancellables: &cancellables,
                          expectedState: .failed(errorMessage: "Network Error")) {
            Task {
                await self.viewModel.loadData()
            }
        }
    }
}
