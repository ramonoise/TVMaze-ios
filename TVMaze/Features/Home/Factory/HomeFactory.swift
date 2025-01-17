import Foundation

@MainActor
class HomeFactory {
    static func build() -> HomeView {
        let viewModel = HomeViewModel(dataSource: TVShowDataSource())
        return HomeView(viewModel: viewModel)
    }
}
