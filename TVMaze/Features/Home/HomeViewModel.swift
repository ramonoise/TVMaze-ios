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
    
    func allShowsSection() async throws -> HomeSectionItem {
        let currentPage = 1
        let allShows = try await dataSource.fetchShows(page: currentPage)
        return HomeSectionItem(title: "All Shows", items: allShows, type: .expanded(page: currentPage))
    }
    
    func loadData() async {
        state = .loading
        do {
            async let sections = [
                allShowsSection()
            ]
            state = try await .loaded(sections: sections)
        } catch {
            state = .failed(errorMessage: "Something odd happened. Try again later.")
        }
    }
}
