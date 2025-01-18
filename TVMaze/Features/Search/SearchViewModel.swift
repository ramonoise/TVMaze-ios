import Combine
import Foundation

enum SearchViewModelState {
    case emptyState
    case loading
    case loaded(shows: [TVShow])
    case noResults
    case failed(errorMessage: String)
}

@MainActor
protocol SearchViewModelProtocol: ObservableObject {
    var searchText: String { get set }
    var state: SearchViewModelState { get set }
    
    func fetchResults()
}

final class SearchViewModel: SearchViewModelProtocol {
    @Published var searchText: String = ""
    @Published var resultsText: String = ""
    @Published var state: SearchViewModelState = .emptyState
    private var dataSource: TVShowDataSourceProtocol
    
    init(dataSource: TVShowDataSourceProtocol = TVShowDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchResults() {
        guard !searchText.isEmpty else {
            self.state = .emptyState
            return
        }
        
        Task {
            self.state = .loading
            do {
                let response = try await dataSource.fetchQuery(query: searchText.lowercased(), page: 1)
                
                resultsText = searchText
                if response.isEmpty {
                    state = .noResults
                } else {
                    state = .loaded(shows: response)
                }
            } catch {
                resultsText = searchText
                self.state = .failed(errorMessage: error.localizedDescription)
            }
        }
    }
}
