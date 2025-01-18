import Foundation

@MainActor
class ShowDetailFactory {
    static func build(showId: Int) -> ShowDetailView {
        let viewModel = ShowDetailViewModel(showId: showId)
        return ShowDetailView(viewModel: viewModel)
    }
}
