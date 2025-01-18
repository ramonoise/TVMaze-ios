import Foundation

@MainActor
class HomeFactory {
    static func build(with dependencies: TVShowDependencies) -> HomeView {
        let coordinator = HomeCoordinator(dependencies: dependencies)
        let viewModel = HomeViewModel(dataSource: dependencies.tvShowDataSource)
        return HomeView(viewModel: viewModel, coordinator: coordinator)
    }
}
