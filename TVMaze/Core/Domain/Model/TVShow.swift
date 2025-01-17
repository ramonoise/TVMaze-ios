import Foundation

struct TVShow: Identifiable, Hashable {
    let id: Int
    let name: String
    let image: TVShowImage
    let genres: [String]
    let schedule: TVShowSchedule
}
