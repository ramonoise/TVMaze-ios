import Foundation

struct TVShowItemResponse: Decodable {
    let id: Int
    let name: String
    let image: Image
    let genres: [String]
    let schedule: Schedule
    
    struct Image: Decodable {
        let mediumURL: String
        let originalURL: String
        
        enum CodingKeys: String, CodingKey {
            case mediumURL = "medium"
            case originalURL = "original"
        }
    }
    
    struct Schedule: Decodable {
        let time: String
        let days: [String]
    }
}

extension TVShowItemResponse {
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
