import Foundation

enum ShowDetailViewModelState {
    case loading
    case loaded(showDetail: TVShowDetail)
    case failed(errorMessage: String)
}

@MainActor
protocol ShowDetailViewModelProtocol: ObservableObject {
    var dataSource: TVShowDataSourceProtocol { get }
    var showId: Int { get }
    
    func loadData() async
}

final class ShowDetailViewModel: ShowDetailViewModelProtocol {
    @Published var state: ShowDetailViewModelState = .loading
    private(set) var dataSource: TVShowDataSourceProtocol
    private(set) var showId: Int
    
    init(showId: Int, dataSource: TVShowDataSourceProtocol) {
        self.showId = showId
        self.dataSource = dataSource
    }
    
    func loadData() async {
        state = .loading
        do {
            let response = try await dataSource.fetchShowDetail(id: showId)
            state = .loaded(showDetail: response)
        } catch {
            state = .failed(errorMessage: error.localizedDescription)
        }
    }
}
