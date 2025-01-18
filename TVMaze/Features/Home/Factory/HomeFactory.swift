import Foundation

@MainActor
class HomeFactory {
    static func build(with dependencies: TVShowDependencies) -> HomeView {
        let viewModel = HomeViewModel(dataSource: dependencies.tvShowDataSource)
        return HomeView(viewModel: viewModel)
    }
}
