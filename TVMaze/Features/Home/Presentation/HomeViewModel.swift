import Foundation

enum HomeViewModelState {
    case loading
    case loaded(sections: [HomeSectionItem])
    case failed(errorMessage: String)
}

@MainActor
protocol HomeViewModelProtocol: ObservableObject {
    var state: HomeViewModelState { get set }
    
    func loadData() async
}

final class HomeViewModel: HomeViewModelProtocol {
    @Published var state: HomeViewModelState = .loading

    private(set) var dataSource: TVShowDataSourceProtocol
    
    init(dataSource: TVShowDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func createAllShowsSection() async throws -> HomeSectionItem {
        let currentPage = 1
        let allShows = try await dataSource.fetchShows(page: currentPage)
        return HomeSectionItem(title: "All Shows", items: allShows, type: .expanded(page: currentPage))
    }
    
    func loadData() async {
        state = .loading
        do {
            let allShows = try await createAllShowsSection()
            state = .loaded(sections: [
                allShows
            ])
        } catch {
            state = .failed(errorMessage: "Something odd happened. Try again later.")
        }
    }
}

@MainActor
class HomeViewModelFactory {
    static func createViewModel() -> HomeViewModel {
        return HomeViewModel(dataSource: TVShowDataSource())
    }
}
