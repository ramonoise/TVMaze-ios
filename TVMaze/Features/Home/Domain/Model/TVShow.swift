import Foundation

struct TVShow: Identifiable {
    let id: Int
    let name: String
    let image: Image
    let genres: [String]
    let schedule: Schedule
    
    struct Image {
        let mediumURL: String
        let originalURL: String
    }
    
    struct Schedule {
        let time: String
        let days: [String]
    }
}
