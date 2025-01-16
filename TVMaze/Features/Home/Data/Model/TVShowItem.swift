import Foundation

struct TVShowItem: Decodable {
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
