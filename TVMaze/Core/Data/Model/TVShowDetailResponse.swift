import Foundation

struct TVShowDetailResponse: Decodable {
    let id: Int
    let name: String
    let image: ImageResponse
    let genres: [String]
    let schedule: ScheduleResponse
    let summary: String
    let episodes: [EpisodeResponse]
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case image
        case genres
        case schedule
        case summary
        case episodes
        case _embedded
    }
    
    enum EmbeddedKeys: CodingKey {
        case episodes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(ImageResponse.self, forKey: .image)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.schedule = try container.decode(ScheduleResponse.self, forKey: .schedule)
        self.summary = try container.decode(String.self, forKey: .summary)
        
        let embeddedContainer = try container.nestedContainer(keyedBy: EmbeddedKeys.self, forKey: ._embedded)
        self.episodes = try embeddedContainer.decode([EpisodeResponse].self, forKey: .episodes)
    }
}

extension TVShowDetailResponse {
    func toDomain() -> TVShowDetail {
        TVShowDetail(id: id,
                     name: name,
                     image: .init(mediumURL: image.mediumURL, originalURL: image.originalURL),
                     genres: genres,
                     schedule: .init(time: schedule.time, days: schedule.days),
                     summary: summary,
                     episodes: episodes.map { $0.toDomain() })
    }
}
