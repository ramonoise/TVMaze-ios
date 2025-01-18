import Foundation

enum HomeSectionItemType: Equatable{
    case simple
    case expanded(page: Int)
}

struct HomeSectionItem: Identifiable, Equatable {
    var id: String { title }
    let title: String
    let items: [TVShow]
    let type: HomeSectionItemType
}
