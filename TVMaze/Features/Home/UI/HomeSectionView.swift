import SwiftUI

enum HomeSectionAccessibilityIdentifier {
    case tvShow(id: Int)
    case title(text: String)
    
    var rawValue: String {
        switch self {
            case let .tvShow(id):
                return "TVShow_\(id)"
            case let .title(text):
                return "Section_Title_\(text)"
        }
    }
}

struct HomeSectionView: View {
    @Environment(\.tvShowDependencies) var dependencies
    var section: HomeSectionItem
    
    var body: some View {
        switch section.type {
            case .expanded(_):
                expandedSection()
            case .simple:
                simpleSection()
        }
    }
    
    @ViewBuilder
    private func titleSection(text: String) -> some View {
        HStack(alignment: .center) {
            Text(text)
                .font(.title2)
                .bold()
                .padding(.leading)
                .accessibilityIdentifier(
                    HomeSectionAccessibilityIdentifier.title(text: text).rawValue
                )
            Spacer()
        }.padding(.top)
    }
    
    @ViewBuilder
    private func expandedSection() -> some View {
        titleSection(text: section.title)
        
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(section.items) { item in
                NavigationLink(value: HomeRoute.showCard(id: item.id)) {
                    TVShowCardView(tvShow: item)
                        .accessibilityIdentifier(
                            HomeSectionAccessibilityIdentifier.tvShow(id: item.id).rawValue
                        )
                }
            }
        }
    }
    
    @ViewBuilder
    private func simpleSection() -> some View {
        titleSection(text: section.title)
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                ForEach(section.items) { item in
                    NavigationLink(value: HomeRoute.showCard(id: item.id)) {
                        TVShowCardView(tvShow: item)
                    }
                }
            }
        }
    }
}
