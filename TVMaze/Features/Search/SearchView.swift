import SwiftUI

enum SearchViewIdentifier: String, RawRepresentable {
    case searchBar = "SearchField"
}

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private func performSearch() {
        viewModel.fetchResults()
    }
    
    var body: some View {
        VStack {
            Group {
                searchBar()
                switch viewModel.state {
                    case .emptyState:
                        Text("Search for TV series, shows, movies...")
                    case .noResults:
                        Text("No results for \"\(viewModel.resultsText)\"")
                    case .loading:
                        ProgressView()
                    case .loaded(let shows):
                        loadedState(shows: shows)
                    case .failed(let errorMessage):
                        Text(errorMessage)
                }
                Spacer()
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: Extensions
private extension SearchView {
    @ViewBuilder func searchBar() -> some View {
        HStack {
            TextField("Search...",
                      text: $viewModel.searchText,
                      onCommit: performSearch)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textInputAutocapitalization(.words)
            .accessibilityIdentifier(
                SearchViewIdentifier.searchBar.rawValue
            )
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.accentColor)
                .onTapGesture(perform: performSearch)
        }.padding()
    }
    
    @ViewBuilder
    func loadedState(shows: [TVShow]) -> some View {
        ScrollView {
            HomeSectionView(
                section: HomeSectionItem(title: "Results for \"\(viewModel.resultsText)\"",
                                         items: shows,
                                         type: .expanded(page: 1)))
        }
    }
}
