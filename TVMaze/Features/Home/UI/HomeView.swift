import SwiftUI

enum HomeAccessibilityIdentifier {
    case search
    case loading
    
    var rawValue: String {
        switch self {
        case .search:
            return "SearchButton"
        case .loading:
            return "LoadingIndicator"
        }
    }
}



struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    private var coordinator: any HomeCoordinatorProtocol
    
    init(viewModel: HomeViewModel, coordinator: any HomeCoordinatorProtocol) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                    case .loading:
                        ProgressView()
                            .accessibilityIdentifier(HomeAccessibilityIdentifier.loading.rawValue)
                        
                    case .loaded(let sections):
                        VStack(alignment: .leading) {
                            ScrollView(showsIndicators: false) {
                                ForEach(sections) { section in
                                    HomeSectionView(section: section)
                                }
                                Spacer()
                            }
                        }
                        .navigationTitle("Home")
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarTrailing) {
                                NavigationLink(value: HomeRoute.search) {
                                    Image(systemName: "magnifyingglass")
                                        .accessibilityIdentifier(
                                            HomeAccessibilityIdentifier.search.rawValue
                                        )
                                }
                            }
                        })
                        
                    case .failed(let errorMessage):
                        Text(errorMessage)
                }
            }
            .navigationDestination(for: HomeRoute.self) { route in
                AnyView(coordinator.resolve(route: route))
            }
        }
        .onAppear {
            Task { await viewModel.loadData() }
        }
    }
}
