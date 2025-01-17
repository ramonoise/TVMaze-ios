import SwiftUI

struct HomeSectionView: View {
    @EnvironmentObject private var router: AppRouter
    var section: HomeSectionItem
       
    var body: some View {
        switch section.type {
            case .simple:
                simpleSection()
            case .expanded(_):
                expandedSection()
        }
    }
    
    @ViewBuilder
    private func simpleSection() -> some View {
        HStack(alignment: .center) {
            Text(section.title)
                .font(.title2)
                .bold()
                .padding(.leading)
            Spacer()
        }.padding(.top)
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                ForEach(section.items) { item in
                    VStack {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 120, height: 180)
                            .cornerRadius(10)
                            .overlay(
                                Text(item.name)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.black.opacity(0.6))
                                    .cornerRadius(5),
                                alignment: .bottom
                            )
                    }.onTapGesture {
                        router.push(route: .show(id: ""))
                    }
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func expandedSection() -> some View {
        HStack(alignment: .center) {
            Text(section.title)
                .font(.title2)
                .bold()
                .padding(.leading)
            Spacer()
        }.padding(.top)
        
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(section.items) { item in
                NetworkAsyncImage(url: URL(string: item.image.mediumURL))
                    .frame(width: 120, height: 180)
                    .cornerRadius(10)
                    .overlay(
                        Text(item.name)
                            .font(.caption)
                            .foregroundColor(.white)
                            .font(.caption)
                            .padding(5)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(2),
                        alignment: .bottom
                    ).onTapGesture {
                        router.push(route: .show(id: ""))
                    }
            }
        }
    }
}
