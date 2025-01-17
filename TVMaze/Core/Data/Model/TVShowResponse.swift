import Foundation

struct TVShowResponse: Decodable {
    let id: Int
    let name: String
    let image: ImageResponse
    let genres: [String]
    let schedule: ScheduleResponse
}

extension TVShowResponse {
    func toDomain() -> TVShow {
        TVShow(id: id,
               name: name, 
               image: .init(mediumURL: image.mediumURL,
                            originalURL: image.originalURL),
               genres: genres,
               schedule: .init(time: schedule.time,
                               days: schedule.days))
    }
}
