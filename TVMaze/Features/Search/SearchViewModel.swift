import Combine
import Foundation

@MainActor
protocol SearchViewModelProtocol: ObservableObject {
    var searchText: String { get set }
    var results: [TVShow] { get set }
    
    func fetchResults()
}

final class SearchViewModel: SearchViewModelProtocol {
    @Published var searchText: String = ""
    @Published var results: [TVShow] = []
    private var dataSource: TVShowDataSourceProtocol
    
    init(dataSource: TVShowDataSourceProtocol = TVShowDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchResults() {
        guard !searchText.isEmpty else {
            results = []
            return
        }
        
        Task {
            do {
                let response = try await dataSource.fetchQuery(query: searchText.lowercased(), page: 1)
                results = response
                debugPrint(response)
            } catch {
                debugPrint(error)
            }
        }
    }
}
