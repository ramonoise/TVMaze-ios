import Foundation

struct TVShowDetail: Equatable {
    let id: Int
    let name: String
    let image: TVShowImage
    let genres: [String]
    let schedule: TVShowSchedule
    let summary: String
    let episodes: [TVShowEpisode]
}

extension TVShowDetail {
    var seasons: [TVShowDetailSeason] {
        var seasonDict = [Int: [TVShowEpisode]]()
        
        for episode in episodes {
            seasonDict[episode.season, default: []].append(episode)
        }
        
        return seasonDict
            .sorted(by: { $0.key < $1.key })
            .map { TVShowDetailSeason(seasonNumber: $0.key, episodes: $0.value) }
    }
}
