import SwiftUI

struct AppCoordinatorView: View {
    @Environment(\.tvShowDependencies) private var dependencies
    
    var body: some View {
        HomeFactory.build(with: dependencies)
    }
}
