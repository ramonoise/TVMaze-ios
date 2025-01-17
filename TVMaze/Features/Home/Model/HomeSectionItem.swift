import Foundation

enum HomeSectionItemType {
    case simple
    case expanded(page: Int)
}

struct HomeSectionItem: Identifiable {
    var id: String { title }
    let title: String
    let items: [TVShow]
    let type: HomeSectionItemType
}
