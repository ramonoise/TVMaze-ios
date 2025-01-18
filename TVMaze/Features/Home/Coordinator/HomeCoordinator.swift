import Foundation
import SwiftUI

enum HomeRoute: Hashable {
    case showCard(id: Int)
    case search
}

protocol HomeCoordinatorProtocol {
    associatedtype ResolvedView: View
    
    var dependencies: TVShowDependencies { get }
    
    func resolve(route: HomeRoute) -> ResolvedView
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    var dependencies: TVShowDependencies
    
    init(dependencies: TVShowDependencies) {
        self.dependencies = dependencies
    }
    
    @MainActor
    func resolve(route: HomeRoute) -> some View {
        switch route {
            case .showCard(let id):
                TypedAnyView(ShowDetailFactory.build(showId: id, with: dependencies))
            case .search:
                TypedAnyView(SearchFactory.build(with: dependencies))
        }
    }
}
