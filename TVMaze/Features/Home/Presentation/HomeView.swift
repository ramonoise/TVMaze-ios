import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var router: AppRouter
    
    @ViewBuilder
    private func categoryListView(category: String) -> some View {
        HStack(alignment: .center) {
            Text(category)
                .font(.title2)
                .bold()
                .padding(.leading)
            Spacer()
        }.padding(.top)
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                ForEach(0..<10, id: \.self) { movie in
                    VStack {
                        // Simulate a poster image with a rounded rectangle
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 120, height: 180)
                            .cornerRadius(10)
                            .overlay(
                                Text("Show's name")
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
    private func allShows() -> some View {
        HStack(alignment: .center) {
            Text("All shows")
                .font(.title2)
                .bold()
                .padding(.leading)
            Spacer()
        }.padding(.top)
        
        
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(0..<12) { _ in
                // Simulate a poster image with a rounded rectangle
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 120, height: 180)
                    .cornerRadius(10)
                    .overlay(
                        Text("Show's name")
                            .font(.caption)
                            .foregroundColor(.white)
                            .font(.caption)
                            .padding(5)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(5),
                        alignment: .bottom
                    ).onTapGesture {
                        router.push(route: .show(id: ""))
                    }
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(alignment: .leading) {
                ScrollView(showsIndicators: false) {
//                    categoryListView(category: "Drama")
//                    categoryListView(category: "Comedy")
                    
                    allShows()
                    
                    Spacer()
                }
            }
            .navigationTitle("TVMaze")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        router.push(route: .search)
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            })
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppRouter())
}
