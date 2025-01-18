import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private func performSearch() {
        viewModel.fetchResults()
    }
    
    private var shouldPresentResults: Bool {
        viewModel.searchText.isEmpty == false
        && viewModel.results.isEmpty == false
    }
    
    var body: some View {
        VStack {
            TextField("Search TV series, shows, etc",
                      text: $viewModel.searchText,
                      onCommit: performSearch)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textInputAutocapitalization(.words)
            .padding()
            
            ScrollView() {
                Group {
                    if shouldPresentResults {
                        HomeSectionView(section: .init(title: "Results for \"\(viewModel.searchText)\"",
                                                       items: viewModel.results,
                                                       type: .expanded(page: 1)))
                    } else {
                        Text("No results")
                    }
                }
                
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

