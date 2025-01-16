import SwiftUI

struct AppRouterBaseView: View {
    @StateObject private var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            router
                .build(route: .main)
                .navigationDestination(for: AppRoute.self) { route in
                    router.build(route: route)
                }
        }
        .environmentObject(router)
    }
}

#Preview {
    AppRouterBaseView()
}
