import SwiftUI
import Foundation

enum AppRoute: Hashable, Codable {
    case main
    case search
    case show(id: Int)
    case episode(TVShowEpisode)
}

final class AppRouter: RouterProtocol {
    typealias Route = AppRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder
    func build(route: AppRoute, dependencies: TVShowDependencies) -> some View {
        switch route {
            case .main:
                HomeFactory.build(with: dependencies)
            case let .show(id):
                ShowDetailFactory.build(showId: id, with: dependencies)
            case .episode(let episode):
                EpisodeFactory.build(episode: episode)
            case .search:
                SearchFactory.build(with: dependencies)
        }
    }
}

//public protocol NavigationDestination: Hashable, Equatable, Identifiable {
//    associatedtype Content: View
//    @MainActor @ViewBuilder var view: Self.Content { get }
//}
//
//extension NavigationDestination {
//    public var id: Int {
//        self.hashValue
//    }
//    public static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.id == rhs.id
//    }
//    @MainActor public func callAsFunction() -> some View {
//        view
//    }
//    @MainActor public func asAnyView() -> AnyView {
//        AnyView(view)
//    }
//}
//
//extension AppRoute: NavigationDestination {
//    @MainActor
//    public var view: some View {
//        Group {
//            switch self {
//                case .main:
//                    HomeFactory.build()
//                case let .show(id):
//                    ShowDetailFactory.build(showId: id)
//                case .episode(let episode):
//                    EpisodeFactory.build(episode: episode)
//                case .search:
//                    SearchFactory.build()
//            }
//        }
//    }
//}
//
//extension View {
//    @MainActor
//    public func navigationDestination<D: NavigationDestination>(_ destinations: D.Type) -> some View {
//        self.navigationDestination(for: D.self) { destination in
//            destination()
//        }
//    }
//}
