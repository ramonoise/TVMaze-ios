import Foundation

struct ImageResponse: Decodable {
    let mediumURL: String
    let originalURL: String
    
    enum CodingKeys: String, CodingKey {
        case mediumURL = "medium"
        case originalURL = "original"
    }
}
