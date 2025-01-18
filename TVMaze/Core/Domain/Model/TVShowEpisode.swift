import Foundation

struct TVShowEpisode: Identifiable, Hashable {
    let id: Int
    let name: String
    let number: Int
    let season: Int
    let summary: String
    let image: TVShowImage?
}
