import Foundation

struct TVShowImage: Decodable, Hashable {
    let mediumURL: String
    let originalURL: String
}


extension TVShowImage {
    static func dummy() -> TVShowImage {
        let dummyImageURL: String = "https://dummyimage.com/150"
        
        return TVShowImage(mediumURL: dummyImageURL,
                           originalURL: dummyImageURL)
    }
}
