import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            switch viewModel.state {
                case .loading:
                    ProgressView()
                    
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
                            Button {
                                router.push(route: .search)
                            } label: {
                                Image(systemName: "magnifyingglass")
                            }
                        }
                    })
                    
                case .failed(let errorMessage):
                    Text(errorMessage)
            }
        }
        .onAppear {
            Task { await viewModel.loadData() }
        }
    }
}
