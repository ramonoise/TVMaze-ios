import Foundation

enum SearchFactory {
    @MainActor static func build() -> SearchView {
        let viewModel = SearchViewModel(dataSource: TVShowDataSource())
        return SearchView(viewModel: viewModel)
    }
}
