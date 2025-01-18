import Foundation
import SwiftUI

enum ShowDetailRoute: Hashable {
    case episode(TVShowEpisode)
}

protocol ShowDetailCoordinatorProtocol {
    var dependencies: TVShowDependencies { get }
    func resolve(route: ShowDetailRoute) -> any View
}

final class ShowDetailCoordinator: ShowDetailCoordinatorProtocol {
    var dependencies: TVShowDependencies
    
    init(dependencies: TVShowDependencies) {
        self.dependencies = dependencies
    }
    
    func resolve(route: ShowDetailRoute) -> any View {
        Group {
            switch route {
                case .episode(let episode):
                    EpisodeFactory.build(episode: episode)
            }
        }
    }
}
