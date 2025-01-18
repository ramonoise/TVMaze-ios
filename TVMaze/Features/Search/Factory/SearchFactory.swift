import Foundation

enum SearchFactory {
    @MainActor static func build(with dependencies: TVShowDependencies) -> SearchView {
        let viewModel = SearchViewModel(dataSource: dependencies.tvShowDataSource)
        return SearchView(viewModel: viewModel)
    }
}
