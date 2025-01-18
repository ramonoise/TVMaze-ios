import SwiftUI

struct AppRouterBaseView: View {
    @Environment(\.tvShowDependencies) private var dependencies
    
    var body: some View {
        HomeFactory.build(with: dependencies)
    }
}

#Preview {
    AppRouterBaseView()
}
