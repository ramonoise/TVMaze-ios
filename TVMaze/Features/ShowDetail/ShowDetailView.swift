import CachedAsyncImage
import SwiftUI

struct ShowDetailView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel: ShowDetailViewModel
    
    init(viewModel: ShowDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
                CachedImageWithFallback(imageUrl: show.image.originalURL,
                                        fallbackUrl: show.image.mediumURL)
                .scaledToFill()
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                .clipped()
                .cornerRadius(10)
                
                Text(show.name)
                    .font(.title)
                    .bold()
                
                Text("Genres: \(show.genres.joined(separator: ", "))")
                    .font(.subheadline)
                
                Text("Airs at \(show.schedule.time) on \(show.schedule.days.joined(separator: ", "))")
                    .font(.subheadline)
                
                RichTextView(html: show.summary)
                    .font(.body)
                
                episodeSection(show)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func episodeSection(_ show: TVShowDetail) -> some View {
        Text("Episodes")
            .font(.title2)
            .bold()
        
        ForEach(show.seasons) { season in
            ShowDetailSeasonEpisodesView(season: season)
        }
    }
}
