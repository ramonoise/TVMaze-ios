import SwiftUI

struct ShowDetailSeasonEpisodesView: View {
    @EnvironmentObject private var router: AppRouter
    var season: TVShowDetailSeason
    
    init(season: TVShowDetailSeason) {
        self.season = season
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Season \(season.seasonNumber)")
                .font(.title3)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(season.episodes) { episode in
                        VStack {
                            CachedImageWithFallback(imageUrl: episode.image?.mediumURL,
                                                    fallbackUrl: episode.image?.originalURL)
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .clipped()
                            .cornerRadius(5)
                            Text(episodeName(episode, limitingFactor: 12))
                                .font(.caption)
                        }
                        .onTapGesture {
                            router.push(route: .episode(episode))
                        }
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
