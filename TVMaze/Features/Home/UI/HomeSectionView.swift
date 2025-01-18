import SwiftUI
import CachedAsyncImage

struct HomeSectionView: View {
    @EnvironmentObject private var router: AppRouter
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
            Spacer()
        }.padding(.top)
    }
    
    @ViewBuilder
    private func expandedSection() -> some View {
        titleSection(text: section.title)
        
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(section.items) { item in
                TVShowCardView(tvShow: item)
                    .onTapGesture {
                        router.push(route: .show(id: item.id))
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
                    VStack {
                        TVShowCardView(tvShow: item)
                    }.onTapGesture {
                        router.push(route: .show(id: item.id))
                    }
                }
            }
        }
    }
}
