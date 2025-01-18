import SwiftUI
import Foundation

enum AppRoute: Hashable {
    case main
    case search
    case show(id: Int)
    case episode(TVShowEpisode)
}

final class AppRouter: RouterProtocol {
    typealias Route = AppRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder
    func build(route: AppRoute) -> some View {
        switch route {
            case .main:
                HomeFactory.build()
            case let .show(id):
                ShowDetailFactory.build(showId: id)
            case .episode(let episode):
                EpisodeFactory.build(episode: episode)
            case .search:
                SearchFactory.build()
        }
    }
}
