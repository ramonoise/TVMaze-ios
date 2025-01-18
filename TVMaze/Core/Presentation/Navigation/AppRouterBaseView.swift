import SwiftUI

struct AppRouterBaseView: View {
    @StateObject private var router = AppRouter()
    @Environment(\.tvShowDependencies) private var resolver
    
    var body: some View {
        NavigationStack(path: $router.path) {
            router
                .build(route: .main, dependencies: resolver)
                .navigationDestination(for: AppRoute.self) { route in
                    router.build(route: route, dependencies: resolver)
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    AppRouterBaseView()
}
