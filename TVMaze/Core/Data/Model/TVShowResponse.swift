import Foundation

struct TVShowResponse: Decodable {
    let id: Int
    let name: String
    let image: ImageResponse
}

struct TVSearchShowResponse: Decodable {
    let show: TVShowResponse
}

// MARK: Extensions

extension TVShowResponse {
    func toDomain() -> TVShow {
        TVShow(id: id,
               name: name,
               image: .init(mediumURL: image.mediumURL,
                            originalURL: image.originalURL))
    }
}

extension TVSearchShowResponse {
    func toDomain() -> TVShow {
        TVShow(id: show.id,
               name: show.name,
               image: .init(mediumURL: show.image.mediumURL,
                            originalURL: show.image.originalURL))
    }
}
