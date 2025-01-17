import SwiftUI
import Foundation

enum AppRoute: Hashable {
    case main
    case search
    case show(item: TVShow)
    case episode(id: String)
}

final class AppRouter: RouterProtocol {
    typealias Route = AppRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder
    func build(route: AppRoute) -> some View {
        switch route {
            case .main:
                HomeFactory.build()
            case .search:
                SearchView()
            case let .show(item):
                ShowView(tvShow: item)
            case .episode(_):
                EpisodeView()
        }
    }
}
