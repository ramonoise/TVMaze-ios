import SwiftUI
import Foundation

enum AppRoute: Hashable {
    case main
    case search
    case show(id: String)
    case episode(id: String)
}

final class AppRouter: RouterProtocol {
    typealias Route = AppRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder
    func build(route: AppRoute) -> some View {
        switch route {
            case .main:
                HomeView()
            case .search:
                SearchView()
            case .show(_):
                ShowView()
            case .episode(_):
                EpisodeView()
        }
    }
}
