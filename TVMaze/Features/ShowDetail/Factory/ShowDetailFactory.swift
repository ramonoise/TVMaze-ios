import Foundation

@MainActor
class ShowDetailFactory {
    static func build(showId: Int, with dependencies: TVShowDependencies) -> ShowDetailView {
        let coordinator = ShowDetailCoordinator(dependencies: dependencies)
        let viewModel = ShowDetailViewModel(showId: showId, dataSource: dependencies.tvShowDataSource)
        return ShowDetailView(viewModel: viewModel, coordinator: coordinator)
    }
}
