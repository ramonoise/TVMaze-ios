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
        Group {
            switch route {
                case .showCard(let id):
                    ShowDetailFactory.build(showId: id, with: dependencies)
                case .search:
                    SearchFactory.build(with: dependencies)
            }
        }
    }
}
