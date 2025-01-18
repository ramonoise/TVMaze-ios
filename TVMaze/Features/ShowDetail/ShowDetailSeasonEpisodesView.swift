import SwiftUI

struct ShowDetailSeasonEpisodesView: View {
    private var coordinator: any ShowDetailCoordinatorProtocol
    var season: TVShowDetailSeason
    
    init(season: TVShowDetailSeason, coordinator: any ShowDetailCoordinatorProtocol) {
        self.season = season
        self.coordinator = coordinator
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Season \(season.seasonNumber)")
                .font(.title3)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(season.episodes) { episode in
                        NavigationLink(value: ShowDetailRoute.episode(episode)) {
                            VStack {
                                AsyncImageWithFallback(imageUrl: episode.image?.mediumURL,
                                                       fallbackUrl: episode.image?.originalURL)
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .clipped()
                                .cornerRadius(5)
                                
                                Text(episodeName(episode, limitingFactor: 12))
                                    .foregroundStyle(.primary)
                                    .font(.caption)
                                    .accessibilityIdentifier(
                                        ShowDetailViewIdentifier.episode(id: episode.id)
                                    )
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

// MARK: Extensions
private extension ShowDetailSeasonEpisodesView {
    func episodeName(_ episode: TVShowEpisode, limitingFactor: Int) -> String {
        let name = episode.name.count > limitingFactor
        ? "\(String(episode.name.prefix(limitingFactor)))..."
        : episode.name
        
        return "\(episode.number): \(name)"
    }
}
