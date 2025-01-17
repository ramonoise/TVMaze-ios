import Foundation

struct EpisodeResponse: Decodable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let image: ImageResponse?
}

extension EpisodeResponse {
    func toDomain() -> TVShowEpisode {
        var domainImage: TVShowImage?
        if let image = self.image {
            domainImage = TVShowImage(mediumURL: image.mediumURL, originalURL: image.originalURL)
        }
        
        return TVShowEpisode(id: id,
                             name: name,
                             number: number,
                             season: season,
                             summary: summary,
                             image: domainImage)
    }
}
