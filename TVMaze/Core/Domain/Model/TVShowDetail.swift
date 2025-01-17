import Foundation

struct TVShowDetail: Decodable {
    let id: Int
    let name: String
    let image: TVShowImage
    let genres: [String]
    let schedule: TVShowSchedule
    let summary: String
    let episodes: [TVShowEpisode]
}
