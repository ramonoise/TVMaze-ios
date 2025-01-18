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
                CachedImageWithFallback(imageUrl: item.image.mediumURL)
                    .bordered()
                    .textOverlay(text: item.name)
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
                        Rectangle()
                            .fill(Color.gray)
                            .bordered()
                            .textOverlay(text: item.name)
                    }.onTapGesture {
                        router.push(route: .show(id: item.id))
                    }
                }
            }
        }
    }
    
    
}

// MARK: Extension
private extension View {
    func bordered() -> some View {
        self.frame(width: 120, height: 180)
            .cornerRadius(10)
    }
    
    func textOverlay(text: String) -> some View {
        self.overlay(
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .font(.caption)
                .padding(5)
                .background(Color.black.opacity(0.6))
                .cornerRadius(5),
            alignment: .bottom
        )
    }
}
