import SwiftUI

enum ShowDetailViewIdentifier: String, RawRepresentable {
    case title = "ShowDetail_Title"
    case genres = "ShowDetail_Genres"
    case airDate = "ShowDetail_AirDate"
    case summary = "ShowDetail_Summary"
    case episodes = "ShowDetail_Episodes"
    
    static func episode(id: Int) -> String {
        "ShowDetail_Episode_\(id)"
    }
}

struct ShowDetailView: View {
    @StateObject private var viewModel: ShowDetailViewModel
    private var coordinator: any ShowDetailCoordinatorProtocol
    
    init(viewModel: ShowDetailViewModel, coordinator: any ShowDetailCoordinatorProtocol) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded(let showDetail):
                    loadedView(show: showDetail)
                case .failed(let errorMessage):
                    Text(errorMessage)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}

// MARK: Extensions
private extension ShowDetailView {
    @ViewBuilder
    func loadedView(show: TVShowDetail) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageWithFallback(imageUrl: show.image.originalURL,
                                       fallbackUrl: show.image.mediumURL)
                .scaledToFill()
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                .clipped()
                .cornerRadius(10)
                
                Text(show.name)
                    .font(.title)
                    .bold()
                    .accessibilityIdentifier(
                        ShowDetailViewIdentifier.title.rawValue
                    )
                
                Text("Genres: \(show.genres.joined(separator: ", "))")
                    .font(.subheadline)
                    .accessibilityIdentifier(
                        ShowDetailViewIdentifier.genres.rawValue
                    )
                
                Text("Airs at \(show.schedule.time) on \(show.schedule.days.joined(separator: ", "))")
                    .font(.subheadline)
                    .accessibilityIdentifier(
                        ShowDetailViewIdentifier.airDate.rawValue
                    )
                
                RichTextView(html: show.summary)
                    .font(.body)
                    .accessibilityIdentifier(
                        ShowDetailViewIdentifier.summary.rawValue
                    )
                
                episodeSection(show)
            }
            .padding()
        }
        .navigationDestination(for: ShowDetailRoute.self, destination: { route in
            AnyView(coordinator.resolve(route: route))
        })
    }
    
    @ViewBuilder
    func episodeSection(_ show: TVShowDetail) -> some View {
        Group {
            Text("Episodes")
                .font(.title2)
                .bold()
            
            ForEach(show.seasons) { season in
                ShowDetailSeasonEpisodesView(season: season, coordinator: coordinator)
            }
        }.accessibilityIdentifier(
            ShowDetailViewIdentifier.episodes.rawValue
        )
    }
}
