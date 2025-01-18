import Foundation

struct TVShowDetailSeason: Identifiable {
    let seasonNumber: Int
    let episodes: [TVShowEpisode]
    
    var id: Int { seasonNumber }
}
